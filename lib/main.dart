import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';
import 'home.dart';
import 'intro.dart';
import 'create.dart';

void main() => runApp(Planner());

class Planner extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
      WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
			statusBarIconBrightness: Brightness.dark,
			statusBarColor: Color(0x00BABADB),
         systemNavigationBarColor: Color(0xFFF6F6FC),
         systemNavigationBarIconBrightness: Brightness.dark,
         systemNavigationBarDividerColor: Color(0xFFFF0000)
		));

		return FutureBuilder<bool>(
         future: isSignedIn(),
         builder: (context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) return Container(color: Color(0xFFF2F2F5));
            return MaterialApp(
               color: Color(0xFFF6F6FC),
               theme: ThemeData(fontFamily: 'Manrope'),
               title: 'Yaayyay',
               initialRoute: snapshot.data ? '/home' : '/init',
               routes: {
                  '/init': (context) => FirstRun(),
                  '/home': (context) => HomePage(),
                  '/create': (context) => CreatePage(),
                  '/account': (context) => AccountPage(),
               },
            );
         }
      );
	}
}

class AccountPage extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
      return Scaffold(
         body: Center(
            child: Text('cool'),
         )
      );
   }
}
