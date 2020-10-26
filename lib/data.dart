import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:tasker/reusable/slikker.dart';

bool signedIn; User user; CollectionReference firestoreDB;
Box app; Box data; 

Map<String, dynamic> getDefaults() => {
   'time': DateTime.now().millisecondsSinceEpoch,
   'light': true,
   'accent': 240,
};

Future<bool> signIn({ bool silently = true }) async {
   await Firebase.initializeApp();
   refreshStatus('Initializing..');
   return (silently ? GoogleSignIn().signInSilently() : GoogleSignIn().signIn())
   .then((account) async {
      refreshStatus('Authoricating..');
      GoogleSignInAuthentication auth = await account.authentication;
      print(auth.serverAuthCode);
      return FirebaseAuth.instance.signInWithCredential(
         GoogleAuthProvider.credential(
            accessToken: auth.accessToken,
            idToken: auth.idToken
         )
      )
      .then((credential) { 
         user = credential.user; 
         app.put('isSignedIn', true);
         firestoreConnect(); 
         return true; 
      });
   }).catchError((a) => false);
}

firestoreConnect() async {
   refreshStatus('Connecting..');
   firestoreDB = FirebaseFirestore.instance.collection(user.uid);

   Map<String, dynamic> tempSettings = Map<String, dynamic>.from(data.get('.settings') ?? {});
   getDefaults().forEach((key, value) => tempSettings[key] = key == 'time' ? value : tempSettings[key] ?? value);
   data.clear();

   firestoreDB.snapshots(includeMetadataChanges: true).listen((event) => event.docChanges
   .where((docChange) => (data.get(docChange.doc.id) ?? { 'time': 0 })['time'] < docChange.doc.data()['time'] 
      || docChange.type == DocumentChangeType.removed) 
   .forEach((change) {
      if (change.type == DocumentChangeType.removed) data.delete(change.doc.id);
      else data.put(change.doc.id, change.doc.data());
   }));

   data.watch().listen((event) { if (event.value != null) firestoreDB.doc(event.key).set(event.value); });

   data.put('.settings', tempSettings);
   firestoreDB.doc('.settings').set(tempSettings);

   refreshStatus('');
}

Function connectivityStatusRefresher = (a) {}; String connectivityStatus = '';
void refreshStatus(String status) { connectivityStatusRefresher(status); connectivityStatus = status; }

void uploadData(String type, Map map) {
   map['time'] = DateTime.now().millisecondsSinceEpoch;
   data.put(type + map['time'].toString(), map);
}

Color accentColor(double alpha, double hue, double saturation, double value) => HSVColor.fromAHSV(alpha, hue, saturation, value).toColor();