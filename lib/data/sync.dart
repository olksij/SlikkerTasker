// Databases
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

// Initialize local varibales
late Box app, cache;
late Box<Map> tasks, collections;

late CollectionReference firestore;
enum SyncData { settings, tasks, collections }

// Default settings
Map<String, dynamic> defaults = {
  'light': true,
  'accent': 240,
  'signin': null,
};

// Merge Hive and Firestore data
void syncData(String key, dynamic value,
    {bool settings = false, bool local = true, bool map = false}) {
  bool remove = value == null;
  late Box data;
  late int time;

  if (settings) {
    data = app;
    time = app.get('time') ?? 0;
  } else {
    if (key[0] == 'T') data = tasks;
    if (key[0] == 'C') data = collections;
    time = app.get(key)?['time'] ?? 0;
  }

  // If the local data is newwer, update data in the cloud.
  if (!local && time > (value?['time'] ?? 0) && !remove) local = true;

  // Give data a time id
  if (local) value['time'] = DateTime.now().millisecondsSinceEpoch;

  // Sync locally
  remove
      ? data.delete(key)
      : map && settings
          ? data.putAll(value)
          : data.put(key, value);

  // Upload changes
  if (local) if (remove)
    firestore.doc(key).delete();
  else
    firestore
        .doc(settings ? 'settings' : key)
        .set(settings ? Map<String, dynamic>.from(data.toMap()) : value);
}

// Connect Firestore listener
void connect(String uid) async {
  firestore = FirebaseFirestore.instance.collection(uid);

  // Merge local and cloud settings
  Map tempSettings = app.toMap();
  defaults
      .forEach((key, value) => tempSettings[key] = tempSettings[key] ?? value);

  // Firestore listener
  firestore.snapshots(includeMetadataChanges: true).listen((event) {
    event.docChanges.forEach(
      (change) => syncData(
        change.doc.id,
        change.type == DocumentChangeType.removed ? null : change.doc.data(),
        local: false,
        settings: change.doc.id == 'settings',
        map: true,
      ),
    );
  });

  // Put new settings in DB
  syncData('settings', tempSettings, settings: true, map: true);
}
