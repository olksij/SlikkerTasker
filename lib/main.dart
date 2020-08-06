import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'material.dart';
import 'home.dart';

//import 'dart:developer' as dev;

void main() => runApp(Planner());

class Planner extends StatelessWidget {
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
                  initialRoute: snapshot.data ? '/init' : '/home',
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

   void localSetState(s) => this.setState(() => s());

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
               future: signIn(),
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
