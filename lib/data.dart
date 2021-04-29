import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:tasker/api_http_client.dart';

late Box app;
late Box<Map> data;

late User user;
late CollectionReference firestoreDB;
late GoogleHttpClient httpClient;
late GoogleSignIn googleSignIn =
    GoogleSignIn(scopes: ['https://www.googleapis.com/auth/calendar.readonly']);

Map<String, dynamic> getDefaults() => {
      'time': DateTime.now().millisecondsSinceEpoch,
      'light': true,
      'accent': 240,
    };

Future<bool> signIn({bool silently = true}) async {
  await Firebase.initializeApp();
  refreshStatus('Syncing..');

  GoogleSignInAccount? account = silently
      ? await googleSignIn.signInSilently()
      : await googleSignIn.signIn();
  if (account == null) return false;

  GoogleSignInAuthentication auth = await account.authentication;

  UserCredential credential = await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken));

  httpClient = GoogleHttpClient(await account.authHeaders);
  firestoreConnect(credential);

  return true;
}

Map<String, dynamic> toMap(Map? inp) => Map<String, dynamic>.from(inp ?? {});

void firestoreConnect(UserCredential credential) async {
  user = credential.user!;
  firestoreDB = FirebaseFirestore.instance.collection(user.uid);

  // Merge local and cloud settings
  Map<String, dynamic> tempSettings = toMap(data.get('.settings'));
  getDefaults().forEach((key, value) =>
      tempSettings[key] = key == 'time' ? value : tempSettings[key] ?? value);
  await data.clear();

  // Connect firebase listener
  firestoreDB.snapshots(includeMetadataChanges: true).listen((event) => event
          .docChanges
          .where((docChange) =>
              (data.get(docChange.doc.id)?['time'] ?? 0) <
                  docChange.doc.data()?['time'] ||
              docChange.type == DocumentChangeType.removed)
          .forEach((change) {
        if (change.type == DocumentChangeType.removed)
          data.delete(change.doc.id);
        else
          data.put(change.doc.id, change.doc.data() ?? {});
      }));

  // Connect local listener
  data.watch().listen((event) {
    if (event.value != null)
      firestoreDB.doc(event.key).set(event.value);
    else
      firestoreDB.doc(event.key).delete();
  });

  // Put new settings in DB
  data.put('.settings', tempSettings);
  firestoreDB.doc('.settings').set(Map<String, dynamic>.from(tempSettings));

  refreshStatus('');
}

Function connectivityStatusRefresher = (a) {};
String connectivityStatus = '';
void refreshStatus(String status) {
  connectivityStatusRefresher(status);
  connectivityStatus = status;
}

void uploadData(String type, Map<String, dynamic> map) {
  map['time'] = DateTime.now().millisecondsSinceEpoch;
  data.put(type + map['time'].toString(), map);
}

Future<List<CalendarListEntry>?> getCalendars() async =>
    (await CalendarApi(httpClient).calendarList.list()).items;
