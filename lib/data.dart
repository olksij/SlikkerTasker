import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import 'package:googleapis/calendar/v3.dart';
import 'package:tasker/api_http_client.dart';

late Box app;
late Box<Map> tasks, collections;

late User user;
late CollectionReference firestoreDB;
late GoogleSignIn googleSignIn =
    GoogleSignIn(scopes: ['https://www.googleapis.com/auth/calendar.readonly']);
CalendarClient calendarClient = CalendarClient();

Map<String, dynamic> getDefaults() => {
      'time': DateTime.now().millisecondsSinceEpoch,
      'light': true,
      'accent': 240,
      'signin': null,
    };

Future<bool> signIn({bool silently = true}) async {
  await Firebase.initializeApp();

  if (!silently) {
    tasks = await Hive.openBox('tasks');
    collections = await Hive.openBox('collections');
  }

  GoogleSignInAccount? account = silently
      ? await googleSignIn.signInSilently()
      : await googleSignIn.signIn();
  if (account == null) return false;

  GoogleSignInAuthentication auth = await account.authentication;

  UserCredential credential = await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken));

  if (credential.user == null) return false;

  calendarClient.set(GoogleHttpClient(await account.authHeaders));
  app.put('signin', true);
  firestoreConnect(credential.user!);

  return true;
}

Map<String, dynamic> toMap(Box inp) => Map<String, dynamic>.from(inp.toMap());

void firestoreConnect(User user) async {
  firestoreDB = FirebaseFirestore.instance.collection(user.uid);

  // Merge local and cloud settings
  Map<String, dynamic> tempSettings = toMap(app);
  getDefaults().forEach((key, value) =>
      tempSettings[key] = key == 'time' ? value : tempSettings[key] ?? value);

  firestoreDB.snapshots(includeMetadataChanges: true).listen((event) {
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

enum SyncData { settings, tasks, collections }

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
    firestoreDB.doc(key).delete();
  else
    firestoreDB
        .doc(settings ? 'settings' : key)
        .set(settings ? toMap(data) : value);
}

class CalendarClient {
  final Completer<CalendarApi> _completer = new Completer();

  Future<CalendarApi> get() => _completer.future;

  void set(GoogleHttpClient client) => _completer.complete(CalendarApi(client));
}

Future<List<CalendarListEntry>?> calendars() async {
  CalendarApi api = await calendarClient.get();
  return api.calendarList.list().then((list) => list.items);
}

Future<Map<String, List<Event>?>> events(Iterable<String> collections) async {
  Map<String, List<Event>?> events = {};
  CalendarApi api = await calendarClient.get();
  for (String collection in collections) {
    Events list = await api.events.list(collection);
    events[collection] = list.items;
  }
  return events;
}
