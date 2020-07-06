import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Yaayyay',
			home: Home(),
		);
	}
}

class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	Widget build(BuildContext context) {
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
			statusBarIconBrightness: Brightness.dark,
			systemNavigationBarColor: Color(0xFFF7F7FC), // navigation bar color
			statusBarColor: Color(0x88EFEFF8), // status bar color
		));
		return Scaffold(
			body: SafeArea(
				top: true,
				child: Container(
					color: Color(0xFFF7F7FC),
					child: Padding(
						padding: EdgeInsets.all(30.0),
						child: TextField(
							style: TextStyle(
								fontSize: 17.0,
								color: Colors.black                  
							),
							decoration: new InputDecoration(
								prefixIcon: new Icon( Icons.search, size: 22.0, color: Color(0xFF1F1F33)),
								contentPadding: EdgeInsets.all(15),
								border: new OutlineInputBorder(
									borderSide: BorderSide.none,
									borderRadius: BorderRadius.circular(10),
								),
								hintText: 'Search for anything',
								hintStyle: TextStyle( color: Color(0x88A1A1B2), fontWeight: FontWeight.w600),
								filled: true,
								fillColor: Color(0xCCEDEDF7)
							),
						)
					),
				),
			)
		);
	}
}

