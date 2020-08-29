import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info/package_info.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const double setsVersion = 0.2;

bool signedIn; FirebaseUser user; CollectionReference firestoreDB;
List reminders; Map<String, dynamic> settings123;

Map<String, dynamic> getDefaults(PackageInfo packageInfo) => {
   'appVersion': packageInfo.version,
   'settingsVersion': setsVersion,
   'time': DateTime.now().millisecondsSinceEpoch,
};

Future<FirebaseUser> _signInWithCredential(googleAuth) async {
   FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.getCredential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
      )
   )).user; 
   firestoreDB = Firestore.instance.collection(user.uid);
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

Future<FirebaseUser> signIn() async {
   return await _signInWithCredential(
      await (await GoogleSignIn().signIn()).authentication
   );
}

Stream<QuerySnapshot> getFirestoreData() {
   return firestoreDB.snapshots();
}

firestoreConnect() async {
   Hive.init((await getApplicationDocumentsDirectory()).path);
   Box settings = await Hive.openBox('.settings');
   Box data = await Hive.openBox<Map<String, dynamic>>('data');
   //if (!(await firestoreDB.document('.settings').get()).exists && settings.isEmpty) { 
      settings.putAll(getDefaults((await PackageInfo.fromPlatform()))); 
      await firestoreDB.document('.settings').setData(Map<String,dynamic>.from(settings.toMap()));
   //}
   firestoreDB.snapshots(includeMetadataChanges: true).listen((event) {
      event.documents.forEach((doc) {
         if (doc.documentID == '.settings') {
            if (settings.isEmpty || doc.data['time'] > settings.toMap()['time']) settings.putAll(doc.data);
            else firestoreDB.document('.settings')
            .setData(Map<String,dynamic>.from(settings.toMap()));
         }
         else {
            if (data.get(doc.documentID) != null) {
               if (doc.data['time'] > data.get(doc.documentID)['time']) data.put(doc.documentID, doc.data);
               else firestoreDB.document(doc.documentID).setData(data.get(doc.documentID));
            }
            else data.put(doc.documentID, doc.data);
         }
      });
   });
}

newDoc(Map<String, dynamic> data) {
   firestoreDB.document().setData(data);
}
