import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const double version = 0.9;

bool signedIn; User user; CollectionReference firestoreDB;
Box settings; Box data; Box account;

Map<String, dynamic> getDefaults() => {
   'time': DateTime.now().millisecondsSinceEpoch,
};

Future<bool> _signInWithCredential(Map credential) async {
   credential = credential ?? {}; 
   if (credential['providerId'] == null || credential['signInMethod'] == null || credential['idToken'] == null) { account.clear(); return false; }
   return FirebaseAuth.instance.signInWithCredential(
      OAuthCredential(
         providerId: credential['providerId'],
         signInMethod: credential['signInMethod'],
         idToken: credential['idToken'],
         accessToken: credential['accessToken'],
      )
   )
   .then((c) { user = c.user; firestoreConnect(); return true; })
   .catchError((a) => false); 
}

Future<bool> isSignedIn() async {
   Hive.init((await getApplicationDocumentsDirectory()).path);
   await Firebase.initializeApp();
   settings = await Hive.openBox('.settings');
   data = await Hive.openBox('data');
   account = await Hive.openBox('.account');
   print(account.get('credential'));
   print(account.toMap());
   return _signInWithCredential(account.get('credential'));
}

Future<User> signIn() async {
   return GoogleSignIn().signIn().then((a) async {
      GoogleSignInAuthentication auth = await a.authentication;
      account.put('accessToken', auth.accessToken);
      OAuthCredential credential = GoogleAuthProvider.credential(
         accessToken: auth.accessToken,
         idToken: auth.idToken
      );
      print(credential.asMap());
      account.put('credential', credential.asMap());
      await _signInWithCredential(credential.asMap());
      return user;
   }).catchError((a) => false);
}

Stream<BoxEvent> getDBData() { return data.watch(); }

firestoreConnect() async {
   firestoreDB = FirebaseFirestore.instance.collection(user.uid);
   if (settings.get('version') != version) {
      Map cloudSettings = (await firestoreDB.doc('.settings').get()).data();
      if (settings.isEmpty || (cloudSettings['version'] == version && cloudSettings['time'] > settings.get('time'))) {
         settings.clear(); settings.putAll(cloudSettings);
      }
      else {
         Map<String, dynamic> oldMap = Map<String, dynamic>.from(settings.toMap());
         settings.clear();
         getDefaults().forEach((key, value) => settings.put(key, oldMap[key] ?? value));
         settings.put('version', version);
      }
   }    
   firestoreDB.snapshots(includeMetadataChanges: true).listen((event) => refreshDB(false, snapshot: event.docChanges));
   settings.watch().listen((event) => refreshDB(true, doc: '.settings', value: Map<String, dynamic>.from(settings.toMap())));
   data.watch().listen((event) => refreshDB(true, doc: event.key, value: event.value));
}

void refreshDB(bool isLocal, { List<DocumentChange> snapshot, String doc, Map<String, dynamic> value }) async {
   if (!isLocal) { snapshot
      .where((docChange) => docChange.doc.id != '.settings' ? (data.get(docChange.doc.id) ?? { 'time': 0 })['time'] < docChange.doc.data()['time'] : false) 
      .forEach((change) {
         if (change.type.index == 0 || change.type.index == 1) {
            if (change.doc.id != '.settings') data.put(change.doc.id, change.doc.data()); 
            else settings.putAll(change.doc.data()); 
         }
         else data.delete(change.doc.id); 
      }); 
   }
   else firestoreDB.doc(doc).set(value);
}

void newDoc(Map<String, dynamic> value) {
   data.put('D'+DateTime.now().millisecondsSinceEpoch.toString(), value);
}