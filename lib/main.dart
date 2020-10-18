import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'data.dart';
import 'home.dart';
import 'intro.dart';
import 'create.dart';
import 'timeline.dart';
import 'tracker.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   Hive.init(!kIsWeb ? (await getApplicationDocumentsDirectory()).path : null);
   app = await Hive.openBox('.app');
   data = await Hive.openBox('data');
   signedIn = app.get('isSignedIn');
   if (signedIn ?? false) signIn();
   runApp(Tasker(isSignedIn: signedIn ?? false));
}

class Tasker extends StatelessWidget {
   final bool isSignedIn;

   Tasker({ this.isSignedIn });

	@override Widget build(BuildContext context) {
      WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
			statusBarIconBrightness: Brightness.dark,
			statusBarColor: Color(0x00BABADB),
         systemNavigationBarColor: Color(0xFFF6F6FC),
         systemNavigationBarIconBrightness: Brightness.dark,
         systemNavigationBarDividerColor: Color(0xFFFF0000)
		));

		return MaterialApp(
         color: Color(0xFFF6F6FC),
         theme: ThemeData(fontFamily: 'Manrope'),
         title: 'Tasker :)',
         initialRoute: isSignedIn ? '/home' : '/init',
         routes: {
            '/init': (context) => FirstRun(),
            '/home': (context) => HomePage(),
            '/createTask': (context) => CreatePage(CreatePageType.task),
            '/createProject': (context) => CreatePage(CreatePageType.project),
            '/account': (context) => AccountPage(),
            '/timeline': (context) => TimelinePage(),
            '/tracker': (context) => TrackerPage(),
         },
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
