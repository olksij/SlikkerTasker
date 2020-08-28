import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info/package_info.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const double setsVersion = 0.1;

bool signedIn; FirebaseUser user; CollectionReference firestoreDB;
List reminders; Map<String, dynamic> settings;

Map<String, dynamic> getDefaults(PackageInfo packageInfo) => {
   'appVersion': packageInfo.version,
   'settingsVersion': setsVersion,
};

Future<FirebaseUser> _signInWithCredential(googleAuth) async {
   FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.getCredential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
      )
   )).user; 
   firestoreDB = Firestore.instance.collection(user.uid);
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
   if (!(await firestoreDB.document('.settings').get()).exists) { 
      settings = getDefaults(await PackageInfo.fromPlatform()); 
      await firestoreDB.document('.settings').setData(settings);
   }
   Hive.init((await getApplicationDocumentsDirectory()).path);
   var sttBox = await Hive.openBox('.settings');
   /*firestoreDB.document('.settings').snapshots().listen((event) {
      if (event.data != null) { sttBox.clear();
         event.data.forEach((key, value) {
            sttBox.put(key, value);
         });
      }
   });*/
   print('');
   /*sttBox.watch().listen((event) async {
      await firestoreDB.document('.settings').setData(sttBox.toMap());
   });*/
}

newDoc(Map<String, dynamic> data) {
   firestoreDB.document().setData(data);
}
