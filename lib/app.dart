import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info/package_info.dart';

const double setsVersion = 0.1;

bool signedIn;
FirebaseUser user;
List reminders;
Map<String, dynamic> settings;

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
   if (signedIn != null) return signedIn;

   GoogleSignInAccount signInAccount = await GoogleSignIn().signInSilently(suppressErrors: true);
   if (signInAccount != null) {
      GoogleSignInAuthentication googleAuth = await signInAccount.authentication;
      user = await _signInWithCredential(googleAuth);
      signedIn = true;
   }
   else signedIn = false;
   return signedIn;
}

Future<FirebaseUser> signIn() async {
   if (user != null) return user;
   GoogleSignInAuthentication googleAuth = await (await GoogleSignIn().signIn()).authentication;
   user =  await _signInWithCredential(googleAuth);
   firestoreConnect();
   return user;
}

firestoreConnect() async {
   var firestoreDB = Firestore.instance;
   var testSettings = await firestoreDB.collection(user.uid).document('.settings').get();
   if (testSettings.exists) settings = testSettings.data;
   else { 
      settings = getDefaults(await PackageInfo.fromPlatform()); 
      await firestoreDB.collection(user.uid).document('.settings').setData(settings);
   }
}
