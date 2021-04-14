import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:tasker/data.dart';
import 'package:tasker/home_page.dart';
import 'package:tasker/login_page.dart';
import 'package:tasker/collections_page.dart';
import 'package:tasker/tracker_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) Hive.init((await getApplicationDocumentsDirectory()).path);

  app = await Hive.openBox('.app');
  data = await Hive.openBox('data');
  if (app.get('isSignedIn') ?? false) signIn();

  runApp(Tasker(isSignedIn: app.get('isSignedIn') ?? false));
}

class Tasker extends StatelessWidget {
  final bool? isSignedIn;

  Tasker({this.isSignedIn});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0x00BABADB),
        systemNavigationBarColor: Color(0xFFF6F6FC),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Color(0xFFF6F6FC)));

    return MaterialApp(
      color: Color(0xFFF6F6FC),
      theme: ThemeData(fontFamily: 'Manrope'),
      title: 'Tasker',
      initialRoute: isSignedIn! ? '/home' : '/init',
      routes: {
        '/init': (context) => FirstRun(),
        '/home': (context) => HomePage(),
        '/account': (context) => AccountPage(),
        '/collections': (context) => CollectionsPage(),
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
    ));
  }
}

Color accentColor(double alpha, double hue, double saturation, double value) =>
    HSVColor.fromAHSV(alpha, hue, saturation, value).toColor();
