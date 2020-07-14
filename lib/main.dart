import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
			statusBarIconBrightness: Brightness.dark,
			systemNavigationBarColor: Color(0xFFF7F7FC),
			statusBarColor: Color(0x25BABADB),
		));
		return Scaffold(
         backgroundColor: Color(0xFFF7F7FC),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton: Center(child: FloatingButton(), heightFactor: 1,),
         body: SafeArea(
				top: true,
            child: Padding(
               padding: EdgeInsets.all(30.0),
               child: CustomScrollView(
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

class FloatingButton extends StatefulWidget { 
   @override 
   _FloatingButtonState createState() => _FloatingButtonState(); }

class _FloatingButtonState extends State<FloatingButton> {
      double _shadowBlur = 40;
      Color _shadowColor = Color(0x194D4DFF);
      double _positionOffsetBottom = 11;
      Color _bottomColor = Color(0xFFF2F2FF);
      Offset _shadowOffset = Offset(0, 10);


   void _hover(){
      setState(() {
         _shadowBlur = 30;
         _shadowColor = Color(0x154D4DFF);
         _positionOffsetBottom = 11;
         _bottomColor = Color(0xFFEBEBFF);
         _shadowOffset = Offset(0, 8);
      });
   }

   void _rest(){
      setState(() {
         _shadowBlur = 40;
         _shadowColor = Color(0x194D4DFF);
         _positionOffsetBottom = 14;
         _bottomColor = Color(0xFFF3F3FF);
         _shadowOffset = Offset(0, 10);
      });
   }

   @override
   Widget build(BuildContext context) {
      return Container( 
         margin: EdgeInsets.only(bottom: _positionOffsetBottom),
         decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(27),
            color: Colors.white,
            boxShadow: [
               BoxShadow (
                  color: _shadowColor,
                  offset: _shadowOffset,
                  blurRadius: _shadowBlur,
               ), 
               BoxShadow (
                  color: _bottomColor,
                  offset: Offset(0,3),
                  blurRadius: 0,
               ),
            ],          
         ),
         child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Material(
               child: InkWell(
                  splashColor: Color(0x106666FF),
                  highlightColor: Color(0x086666FF),
                  onTapDown: (h) { _hover();},
                  onTapCancel: () { _rest(); },
                  onTap: () { _rest(); },
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
         ),
      );
   }
}