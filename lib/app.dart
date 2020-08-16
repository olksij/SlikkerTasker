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

Future<bool> isSignedIn() async {
   if (signedIn != null) return signedIn;
   signedIn = await GoogleSignIn().isSignedIn();
   return signedIn;
}

Future<FirebaseUser> signIn() async {
   if (user != null) return user;
   signedIn = false;
   GoogleSignInAccount googleAccount = signedIn
      ? await GoogleSignIn().signInSilently() : await GoogleSignIn().signIn();
   GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

   final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
   );

   user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
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
