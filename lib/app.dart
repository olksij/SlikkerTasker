import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

bool firstRun;
FirebaseUser user;

final prefs = SharedPreferences.getInstance();

Future<bool> isFirstRun() async {
   if (firstRun != null) return firstRun;
   firstRun = (await prefs).getBool('firstRun') ?? true;
   if (firstRun) prefs.then((prefs) => prefs.setBool('firstRun', false));
   return firstRun;
}

Future<FirebaseUser> signIn() async {
   if (user != null) return user;
   GoogleSignInAccount googleAccount = await GoogleSignIn().isSignedIn() ? await GoogleSignIn().signInSilently() : await GoogleSignIn().signIn();
   GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

   final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
   );

   user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
   return user;
}
