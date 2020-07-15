import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Yaayyay',
			home: Home(),
		);
	}
}

class Home extends StatelessWidget {
	Widget build(BuildContext context) {
      WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
			statusBarIconBrightness: Brightness.dark,
			systemNavigationBarColor: Color(0xFFF7F7FC),
			statusBarColor: Color(0x25BABADB),
		));
		return Scaffold(
         backgroundColor: Color(0xFFF7F7FC),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton: FloatingButton(title: 'Heyy', icon: Icons.add,),
         body: SafeArea(
				top: true,
            child: Padding(
               padding: EdgeInsets.all(30.0),
               child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                     SliverAppBar( expandedHeight: 300.0, backgroundColor: Color(0xFFF7F7FC) ),
                     SliverAppBar(
                        backgroundColor: Color(0xFFF7F7FC),
                        expandedHeight: 70.0,
                        flexibleSpace: FlexibleSpaceBar(  
                           collapseMode: CollapseMode.pin, 
                           background: Text('Heyyyy', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,),
                        ),
                     ),
                     SliverAppBar(
                        elevation: 0,
                        pinned: true,
                        titleSpacing: 0,
                        expandedHeight: 52,
                        backgroundColor: Color(0xFFF7F7FC),
                        title: SearchBar(),
                     ),
                     SliverFixedExtentList(
                        itemExtent: 400.0,
                        delegate: SliverChildListDelegate(
                           [
                              Container(color: Color(0xFFF7F7FC)),
                              Container(color: Color(0xFF00F7FC)),
                              Container(color: Color(0xFFF700FC)),
                              Container(color: Color(0xFFF7F700)),
                              Container(color: Color(0xFFF700FC)),
                           ],
                        ),
                     ),
                  ],
               )
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
            color: Color(0xFF1F1F33)                 
         ),
         decoration: new InputDecoration(
            prefixIcon: Container(
               padding: EdgeInsets.all(15),
               child: new Icon( Icons.search, size: 22.0, color: Color(0xFF1F1F33)),
            ),
            contentPadding: EdgeInsets.all(17),
            border: new OutlineInputBorder(
               borderSide: BorderSide.none,
               borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Search for anything',
            hintStyle: TextStyle( color: Color(0x88A1A1B2), fontWeight: FontWeight.w600, ),
            filled: true,
            fillColor: Color(0xCCEDEDF7),
         ),
      );
   }
}

