import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info/package_info.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const double setsVersion = 0.3;

bool signedIn; User user; CollectionReference firestoreDB;
List reminders; Box settings; Box data;

Map<String, dynamic> getDefaults(PackageInfo packageInfo) => {
   'appVersion': packageInfo.version,
   'settingsVersion': setsVersion,
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
   GoogleSignInAccount signInAccount = GoogleSignIn().currentUser ?? 
      await GoogleSignIn().signInSilently(suppressErrors: true);
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
   //if (!(await firestoreDB.document('.settings').get()).exists && settings.isEmpty) { 
      settings.putAll(getDefaults((await PackageInfo.fromPlatform()))); 
      await firestoreDB.doc('.settings').set(Map<String,dynamic>.from(settings.toMap()));
   //}
   firestoreDB.snapshots(includeMetadataChanges: true).listen((event) {
      /*event.docs.forEach((doc) {
         if (doc.id == '.settings') {
            if (settings.isEmpty || doc.data()['time'] > settings.toMap()['time']) settings.putAll(doc.data());
            else firestoreDB.doc('.settings')
            .set(Map<String,dynamic>.from(settings.toMap()));
         }
         else {
            if (data.get(doc.id) != null) {
               if (doc.data()['time'] > data.get(doc.id)['time']) data.put(doc.id, doc.data());
               else firestoreDB.doc(doc.id).set(data.get(doc.id));
            }
            else data.put(doc.id, doc.data);
         }
      });*/
      refreshDB(false);
   });
}

void refreshDB(isLocal) async {
   if (!isLocal) firestoreDB.where('time', isGreaterThan: settings.get('lastTimeSync')).get()
   .then((snapshot) => snapshot.docs.forEach((doc) { if (doc.id != '.settings') data.put(doc.id, doc.data()); }));
   settings.put('lastTimeSync', DateTime.now().millisecondsSinceEpoch);
}

newDoc(Map<String, dynamic> data) {
   firestoreDB.doc().set(data);
}
