import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'material.dart';
import 'home.dart';

import 'dart:developer' as dev;

void main() => runApp(Planner());

class Planner extends StatelessWidget {
   Future<bool> isFirstRun() async {
      final prefs = await SharedPreferences.getInstance();
      bool firstRun = prefs.getBool('firstRun') ?? true;
      if (firstRun) SharedPreferences.getInstance().then((prefs) => prefs.setBool('firstRun', false));
      return firstRun;
   }

	@override
	Widget build(BuildContext context) {
      WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
			statusBarIconBrightness: Brightness.dark,
			statusBarColor: Color(0x00BABADB),
         systemNavigationBarColor: Color(0xFFF7F7FC),
         systemNavigationBarIconBrightness: Brightness.dark,
         systemNavigationBarDividerColor: Color(0xFFFF0000)
		));

		return FutureBuilder<bool>(
         future: isFirstRun(),
         builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
               return MaterialApp(
                  theme: ThemeData(fontFamily: 'Manrope'),
                  title: 'Yaayyay',
                  initialRoute: '/init', //snapshot.data ? '/init' : '/home',
                  routes: {
                     '/init': (context) => FirstRun(),
                     '/home': (context) => Home(),
                  },
               );
            } else return Container(color: Color(0xFFF7F7FC),);
         }
      );
	}
}

class FirstRun extends StatefulWidget {
   @override
   _FirstRunState createState() => _FirstRunState();
}

class _FirstRunState extends State<FirstRun> {
   
   var loggingIn = false;
   Future<FirebaseUser> _handleSignIn() async {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      return user;
   }

   void localSetState(s) { 
      this.setState(() => s());
   }

   @override
   Widget build(BuildContext context) {
      return Scaffold(
         body: Center( child: Text("It's first run!") ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton: Layer(
            accent: Color(0xFF6666FF),
            corningStyle: CorningStyle.full,
            position: 1,
            child: loggingIn ? FutureBuilder(
               future: _handleSignIn(),
               builder: (context, user) {
                  if (user.hasData) {
                     Future.delayed(Duration(seconds: 1), () => Navigator.pushNamed(context, '/home'));
                     return Text(user.data.displayName.toString()); 
                  }
                  else return loggingIn ? SizedBox(
                     child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1F1F33)),
                     ),
                     height: 16,
                     width: 16,
                  ) : Text('Continue with Google $loggingIn');
               },
            )
            : Text('Continue with Google'),
            onTap: this.localSetState,
            onTapProp: () => loggingIn = true,
         ),
      );
   }
}
