import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool signedIn;
FirebaseUser user;

final prefs = SharedPreferences.getInstance();

Future<bool> isSignedIn() async {
   if (signedIn != null) return signedIn;
   signedIn = await GoogleSignIn().isSignedIn();
   return signedIn;
}

Future<FirebaseUser> signIn() async {
   if (user != null) return user;
   GoogleSignInAccount googleAccount = signedIn
      ? await GoogleSignIn().signInSilently() : await GoogleSignIn().signIn();
   GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

   final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
   );

   user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
   return user;
}

firestoreConnect() async {
   var firestoreDB = Firestore.instance;
   print('FKJFHJFHFFEJFOINEFOINEHOIHGH3GHGHJFHFFEJFOINEFOINEHOIHGH3GHGHJFHFFEJFOINEFOINEHOIHGH3GHGHJFHFFEJFOINEFOINEHOIHGH3GHGHJFHFFEJFOINEFOINEHOIHGH3GHGHJFHFFEJFOINEFOINEHOIHGH3GHGHJFHFFEJFOINEFOINEHOIHGH3GHGHJFHFFEJFOINEFOINEHOIHGH3GHGHJFHFFEJFOINEFOINEHOIHGH3GHGHJFHFFEJFOINEFOINEHOIHGH3GHG');
   print(firestoreDB.collection(user.uid).document('.settings').get());
}
