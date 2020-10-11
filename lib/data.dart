import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

const double version = 0.9;

bool signedIn; User user; CollectionReference firestoreDB;
Box settings; Box data; 

Map<String, dynamic> getDefaults() => {
   'time': DateTime.now().millisecondsSinceEpoch,
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
         settings.put('isSignedIn', true);
         firestoreConnect(); 
         return true; 
      });
   }).catchError((a) => false);
}

firestoreConnect() async {
   refreshStatus('Connecting..');
   firestoreDB = FirebaseFirestore.instance.collection(user.uid);
   if (settings.get('version') != version) {
      Map cloudSettings = (await firestoreDB.doc('.settings').get()).data();
      if (settings.isEmpty || cloudSettings['time'] > settings.get('time')) {
         settings.putAll(cloudSettings);
      }
      else {
         Map<String, dynamic> oldMap = Map<String, dynamic>.from(settings.toMap());
         settings.clear();
         getDefaults().forEach((key, value) => settings.put(key, oldMap[key] ?? value));
         settings.put('version', version);
      }
      refreshDB(true, doc: '.settings', value: Map<String, dynamic>.from(settings.toMap()));
   }
   firestoreDB.snapshots(includeMetadataChanges: true).listen((event) => refreshDB(false, snapshot: event.docChanges));
   settings.watch().listen((event) => refreshDB(true, doc: '.settings', value: Map<String, dynamic>.from(settings.toMap())));
   data.watch().listen((event) => refreshDB(true, doc: event.key, value: event.value));
   refreshStatus('');
}

void refreshDB(bool isLocal, { List<DocumentChange> snapshot, String doc, Map<String, dynamic> value }) async {
   if (!isLocal) snapshot
      .where((docChange) {
         return data.get(docChange.doc.id)['time'] != null
         && data.get(docChange.doc.id)['time'] < docChange.doc.data()['time'];
      }) 
      .forEach((change) {
         if (change.type.index == 0 || change.type.index == 1) {
            if (change.doc.id != '.settings') data.put(change.doc.id, change.doc.data()); 
            else settings.putAll(change.doc.data()); 
         }
         else data.delete(change.doc.id); 
      }); 
   else firestoreDB.doc(doc).set(value);
}

Function connectivityStatusRefresher = (a) {}; String connectivityStatus = '';
void refreshStatus(String status) { connectivityStatusRefresher(status); connectivityStatus = status; }