import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'material.dart';
import 'home.dart';

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

class FirstRun extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
      return Scaffold(
         body: Center(
            child: Text("It's first run!")
         ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton: Layer(
            accent: Color(0xFF6666FF),
            corningStyle: CorningStyle.full,
            position: 1,
            child: Text('Continue'),
            onTap: () { Navigator.pushNamed(context, '/home'); },
         ),
      );
   }
}