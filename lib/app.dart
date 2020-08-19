import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info/package_info.dart';

const double setsVersion = 0.1;

bool signedIn; FirebaseUser user; Firestore firestoreDB = Firestore.instance;
List reminders; Map<String, dynamic> settings;

Map<String, dynamic> getDefaults(PackageInfo packageInfo) => {
   'appVersion': packageInfo.version,
   'settingsVersion': setsVersion,
};

Future<FirebaseUser> _signInWithCredential(googleAuth) async {
   return (await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.getCredential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
      )
   )).user; 
}

Future<bool> isSignedIn() async {
   GoogleSignInAccount signInAccount = await GoogleSignIn().signInSilently(suppressErrors: true);
   if (signInAccount != null) {
      GoogleSignInAuthentication googleAuth = await signInAccount.authentication;
      user = await _signInWithCredential(googleAuth);
      signedIn = true;
   }
   else signedIn = false;
   //
   /*var testSettings = await firestoreDB.collection(user.uid).
   if (!testSettings.exists) for(int i = 1; i < 4; i++ ){
      await firestoreDB.collection(user.uid).document().setData(getDefaults(await PackageInfo.fromPlatform()));
   }*/
   //
   return signedIn;
}

Future<FirebaseUser> signIn() async {
   GoogleSignInAuthentication googleAuth = await (await GoogleSignIn().signIn()).authentication;
   user =  await _signInWithCredential(googleAuth);
   return user;
}

Stream<QuerySnapshot> getFirestoreData() {

   return firestoreDB.collection(user.uid).snapshots();
}

firestoreConnect() async {
   var testSettings = await firestoreDB.collection(user.uid).document('.settings').get();
   if (testSettings.exists) settings = testSettings.data;
   else { 
      settings = getDefaults(await PackageInfo.fromPlatform()); 
      await firestoreDB.collection(user.uid).document('.settings').setData(settings);
   }
}
