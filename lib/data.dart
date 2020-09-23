import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const double version = 0.9;

bool signedIn; User user; CollectionReference firestoreDB;
List reminders; Box settings; Box data;

Map<String, dynamic> getDefaults() => {
   'time': DateTime.now().millisecondsSinceEpoch,
};

Future<User> _signInWithCredential(googleAuth) async {
   await Firebase.initializeApp();
   user = (await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
      )
   )).user; 

   Hive.init((await getApplicationDocumentsDirectory()).path);
   firestoreDB = FirebaseFirestore.instance.collection(user.uid);
   settings = await Hive.openBox('.settings');
   data = await Hive.openBox('data');

   firestoreConnect();
   return user;
}

Future<bool> isSignedIn() async {
   return GoogleSignIn().isSignedIn().then((signedIn) async { 
      if (signedIn) {
         print((await (GoogleSignIn().currentUser ?? await GoogleSignIn().signInSilently(suppressErrors: true)).authentication).accessToken);
         await _signInWithCredential(
            await (GoogleSignIn().currentUser ?? await GoogleSignIn().signInSilently(suppressErrors: true))
            .authentication
         );
         return true;
      }
      else return false;
   });
}

Future<User> signIn() async {
   return await _signInWithCredential(
      await (
         await GoogleSignIn().signIn()
      ).authentication
   );
}

Stream<BoxEvent> getDBData() { return data.watch(); }

firestoreConnect() async {
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