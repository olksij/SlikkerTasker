// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Hive
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasker/data/adapter.dart';

// Pages
import 'package:tasker/data/data.dart';
import 'package:tasker/home/page.dart';
import 'package:tasker/login/page.dart';
import 'package:tasker/home/collections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) Hive.init((await getApplicationDocumentsDirectory()).path);

  register();

  app = await Hive.openBox('app');
  bool signin = app.get('signin') ?? false;

  if (signin) {
    signIn();
    tasks = await Hive.openBox<Map>('tasks');
    collections = await Hive.openBox<Map>('collections');
    cache = await Hive.openBox('cache');
  }

  runApp(Tasker(signin));
}

class Tasker extends StatelessWidget {
  final bool isSignedIn;

  Tasker(this.isSignedIn);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));

    return MaterialApp(
      color: Color(0xFFF6F6FC),
      theme: ThemeData(fontFamily: 'Manrope'),
      title: 'Tasker',
      initialRoute: isSignedIn ? '/home' : '/init',
      routes: {
        '/init': (context) => FirstRun(),
        '/home': (context) => HomePage(),
        '/account': (context) => AccountPage(),
        '/collections': (context) => CollectionsPage(),
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
      ),
    );
  }
}
