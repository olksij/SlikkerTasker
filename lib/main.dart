import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Yaayyay',
			home: Home(),
         // TODO: Login & Set up page
		);
	}
}

class Home extends StatelessWidget {
	Widget build(BuildContext context) {
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
			statusBarIconBrightness: Brightness.dark,
			systemNavigationBarColor: Color(0xFFF7F7FC),
			statusBarColor: Color(0x25BABADB),
		));
		return Scaffold(
         backgroundColor: Color(0xFFF7F7FC),
         body: SafeArea(
				top: true,
            // TODO: Sliver List
            child: Padding(
               padding: EdgeInsets.all(30.0),
               // TODO: Title
               child: SearchBar()
               // TODO: Create button
            ),
			)
      );
	}
}

class SearchBar extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
      return TextField(
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
      );
   }
}
