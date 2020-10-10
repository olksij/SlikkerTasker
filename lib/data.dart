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
   return (silently ? GoogleSignIn().signInSilently() : GoogleSignIn().signIn())
   .then((account) async {
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
   firestoreDB = FirebaseFirestore.instance.collection(user.uid);
   if (settings.get('version') != version) {
      Map cloudSettings = (await firestoreDB.doc('.settings').get()).data();
      if (settings.isEmpty || (cloudSettings['version'] == version && cloudSettings['time'] > settings.get('time'))) {
         settings.clear(); settings.putAll(cloudSettings);
      }
      else {
         Map<String, dynamic> oldMap = Map<String, dynamic>.from(settings.toMap());
         settings.clear();
         getDefaults().forEach((key, value) => settings.put(key, oldMap[key] ?? value));
         settings.put('version', version);
      }
   }    
   firestoreDB.snapshots(includeMetadataChanges: true).listen((event) => refreshDB(false, snapshot: event.docChanges));
   settings.watch().listen((event) => refreshDB(true, doc: '.settings', value: Map<String, dynamic>.from(settings.toMap())));
   data.watch().listen((event) => refreshDB(true, doc: event.key, value: event.value));
}

void refreshDB(bool isLocal, { List<DocumentChange> snapshot, String doc, Map<String, dynamic> value }) async {
   if (!isLocal) { snapshot
      .where((docChange) => docChange.doc.id != '.settings' ? (data.get(docChange.doc.id) ?? { 'time': 0 })['time'] < docChange.doc.data()['time'] : false) 
      .forEach((change) {
         if (change.type.index == 0 || change.type.index == 1) {
            if (change.doc.id != '.settings') data.put(change.doc.id, change.doc.data()); 
            else settings.putAll(change.doc.data()); 
         }
         else data.delete(change.doc.id); 
      }); 
   }
   else firestoreDB.doc(doc).set(value);
}

void newDoc(Map<String, dynamic> value) {
   data.put('D'+DateTime.now().millisecondsSinceEpoch.toString(), value);
}