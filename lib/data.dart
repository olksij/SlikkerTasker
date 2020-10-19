import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

bool signedIn; User user; CollectionReference firestoreDB;
Box app; Box data; 

Map<String, dynamic> getDefaults() => {
   'time': DateTime.now().millisecondsSinceEpoch,
   'light': true,
   'accent': 240,
};

Future<bool> signIn({ bool silently = true }) async {
   await Firebase.initializeApp();
   refreshStatus('Initializing..');
   return (silently ? GoogleSignIn().signInSilently() : GoogleSignIn().signIn())
   .then((account) async {
      refreshStatus('Authoricating..');
      GoogleSignInAuthentication auth = await account.authentication;
      print(auth.serverAuthCode);
      return FirebaseAuth.instance.signInWithCredential(
         GoogleAuthProvider.credential(
            accessToken: auth.accessToken,
            idToken: auth.idToken
         )
      )
      .then((credential) { 
         user = credential.user; 
         app.put('isSignedIn', true);
         firestoreConnect(); 
         return true; 
      });
   }).catchError((a) => false);
}

firestoreConnect() async {
   refreshStatus('Connecting..');
   firestoreDB = FirebaseFirestore.instance.collection(user.uid);

   Map<String, dynamic> tempSettings = Map<String, dynamic>.from(data.get('.settings') ?? {});
   getDefaults().forEach((key, value) => tempSettings[key] = key == 'time' ? value : tempSettings[key] ?? value);
   data.clear();
   data.put('.settings', tempSettings);
   refreshDB(true, doc: '.settings', value: tempSettings);

   firestoreDB.snapshots(includeMetadataChanges: true).listen((event) => refreshDB(false, snapshot: event.docChanges));
   data.watch().listen((event) => refreshDB(true, doc: event.key, value: event.value));

   refreshStatus('');
}

void refreshDB(bool isLocal, { List<DocumentChange> snapshot, String doc, Map<String, dynamic> value }) async {
   if (!isLocal) snapshot
      .where((docChange) => (data.get(docChange.doc.id) ?? { 'time': 0 })['time'] < docChange.doc.data()['time']) 
      .forEach((change) => data.put(change.doc.id, change.doc.data())); 
   else firestoreDB.doc(doc).set(value);
}

Function connectivityStatusRefresher = (a) {}; String connectivityStatus = '';
void refreshStatus(String status) { connectivityStatusRefresher(status); connectivityStatus = status; }

void uploadData(String type, Map map) {
   map['time'] = DateTime.now().millisecondsSinceEpoch;
   data.put(type + map['time'].toString(), map);
}