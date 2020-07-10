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

class FloatingButton extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
      return Container( 
         decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white
         ),
         child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Material(
               child: InkWell(
                  splashColor: Color(0x106666FF),
                  highlightColor: Color(0x206666FF),
                  onTap: () {},
                  child: Padding(
                     padding: EdgeInsets.all(15),
                     child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                           Icon(Icons.add, color: Color(0xFF6666FF),), 
                           Container(width: 7, height: 24),
                           Text('Heyy ', style: TextStyle(
                              color: Color(0xFF6666FF), fontWeight: FontWeight.w600, fontSize: 16
                           ),)
                        ]
                     ),
                  )
               ),
            ),
         )
      );
   }
}

class Home extends StatelessWidget {
	Widget build(BuildContext context) {
      // TODO: Fix navigation bar color
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
			statusBarIconBrightness: Brightness.dark,
			systemNavigationBarColor: Color(0xFFF7F7FC),
			statusBarColor: Color(0x25BABADB),
		));
		return Scaffold(
         backgroundColor: Color(0xFFF7F7FC),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         // TODO: Improve FAB style
         floatingActionButton: Center(child: FloatingButton(), heightFactor: 1,),
         body: SafeArea(
				top: true,
            child: Padding(
               // TODO: Improve padding
               padding: EdgeInsets.all(30.0),
               child: CustomScrollView(
                  // TODO: Top Button & Top geasture
                  // TODO: Haptic on changing view
                  slivers: <Widget>[
                     SliverAppBar( expandedHeight: 300.0, backgroundColor: Color(0xFFF7F7FC) ),
                     SliverAppBar(
                        backgroundColor: Color(0xFFF7F7FC),
                        expandedHeight: 70.0,
                        flexibleSpace: FlexibleSpaceBar(  
                           collapseMode: CollapseMode.pin, 
                           // TODO: Title
                           background: Text('Heyyyy', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,),
                        ),
                     ),
                     SliverAppBar(
                        elevation: 0,
                        pinned: true,
                        titleSpacing: 0,
                        expandedHeight: 50,
                        backgroundColor: Color(0xFFF7F7FC),
                        title: SearchBar(),
                     ),
                     SliverFixedExtentList(
                        itemExtent: 400.0,
                        delegate: SliverChildListDelegate(
                           [
                              Container(color: Color(0xFFF7F7FC)),
                              Container(color: Color(0xFFF7F7FC)),
                           ],
                        ),
                     ),
                  ],
               )
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
         // TODO: Change SearxhBar height
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
            fillColor: Color(0xCCEDEDF7),
         ),
      );
   }
}