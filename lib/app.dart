import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info/package_info.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const double version = 0.4;

bool signedIn; User user; CollectionReference firestoreDB;
List reminders; Box settings; Box data;

Map<String, dynamic> getDefaults() => {
   'time': DateTime.now().millisecondsSinceEpoch,
   'lastTimeSync': 0,
};

Future<User> _signInWithCredential(googleAuth) async {
   await Firebase.initializeApp();
   User user = (await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
      )
   )).user; 
   firestoreDB = FirebaseFirestore.instance.collection(user.uid);
   firestoreConnect();
   return user;
}

Future<bool> isSignedIn() async {
   GoogleSignInAccount signInAccount = await GoogleSignIn().isSignedIn() ? 
   GoogleSignIn().currentUser ?? await GoogleSignIn().signInSilently(suppressErrors: true) : null;
   if (signInAccount != null) {
      GoogleSignInAuthentication googleAuth = await signInAccount.authentication;
      user = await _signInWithCredential(googleAuth);
      signedIn = true;
   }
   else signedIn = false;
   return signedIn;
}

Future<User> signIn() async {
   return await _signInWithCredential(
      await (await GoogleSignIn().signIn()).authentication
   );
}

Stream<QuerySnapshot> getFirestoreData() {
   return firestoreDB.snapshots();
}

firestoreConnect() async {
   Hive.init((await getApplicationDocumentsDirectory()).path);
   settings = await Hive.openBox('.settings');
   data = await Hive.openBox<Map<String, dynamic>>('data');

   if(settings.get('version') != version) {
      Map<String, dynamic> oldMap = Map<String, dynamic>.from(settings.toMap());
      settings.clear();
      print(settings.toMap());
      getDefaults().forEach((key, value) => settings.put(key, oldMap[key] ?? value));
      settings.put('version', version);
   }      
   await firestoreDB.doc('.settings').set(Map<String,dynamic>.from(settings.toMap()));
   firestoreDB.snapshots(includeMetadataChanges: true).listen((event) => refreshDB(false, event.docChanges));
}

void refreshDB(bool isLocal, [List<DocumentChange> snapshot]) async {
   if (!isLocal) snapshot.where((docChange) => docChange.doc.data()['time'] > settings.get('lastTimeSync'))
   .forEach((change) { if (change.doc.id != '.settings') data.put(change.doc.id, change.doc.data()); });
   settings.put('lastTimeSync', DateTime.now().millisecondsSinceEpoch);
}

void newDoc(Map<String, dynamic> data) {
   firestoreDB.doc().set(data);
}
