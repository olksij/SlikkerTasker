// Firebase & Hive
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

// Local
import 'package:tasker/data/client.dart';
import 'package:tasker/data/sync.dart';

// Initialize user
late User user;
late GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: ['https://www.googleapis.com/auth/calendar.readonly'],
);

// Sign in to Google Account
Future<bool> signIn({bool silently = true}) async {
  // Init Firebase app
  await Firebase.initializeApp();

  if (!silently) {
    Hive.openBox<Map>('tasks').then((box) => tasks = box);
    Hive.openBox<Map>('collections').then((box) => collections = box);
    Hive.openBox('cache').then((box) => cache = box);
  }

  GoogleSignInAccount? account = silently
      ? await googleSignIn.signInSilently()
      : await googleSignIn.signIn();
  if (account == null) return false;

  GoogleSignInAuthentication auth = await account.authentication;

  UserCredential credential = await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken));

  if (credential.user == null) return false;

  account.authHeaders
      .then((headers) => calendarClient.set(GoogleHttpClient(headers)));
  app.put('signin', true);
  connect(credential.user!.uid);
  return true;
}
