import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'material.dart';

class FloatingButton extends StatefulWidget { 
   final String title; final IconData icon;

   const FloatingButton({this.title, this.icon});

   @override 
   _FloatingButtonState createState() => _FloatingButtonState(title: title, icon: icon); }

class _FloatingButtonState extends State<FloatingButton> {
   final String title; final IconData icon;

   _FloatingButtonState({ @required this.title, @required this.icon, });

   @override
   Widget build(BuildContext context) {
      return Layer(
         accent: Color(0xFF6666FF),
         type: LayerType.fab,
         position: 2,
         child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               Icon(icon, color: Color(0xFF6666FF),), 
               Container(width: 7, height: 24),
               Text(title+' ', style: TextStyle(
                  color: Color(0xFF6666FF), fontWeight: FontWeight.w600, fontSize: 16
               ),)
            ]
         ),
      );
   }
}

class SearchBar extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
      return Padding(
         padding: EdgeInsets.symmetric(horizontal: 30),
         child: TextField(
            style: TextStyle(
               fontSize: 16.5,
               color: Color(0xFF1F1F33)                 
            ),
            decoration: InputDecoration(
               prefixIcon: Container(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                     Icons.search, 
                     size: 22.0, 
                     color: Color(0xFF1F1F33)
                  ),
               ),
               contentPadding: EdgeInsets.all(15),
               border: new OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
               ),
               hintText: 'Search for anything',
               hintStyle: TextStyle( color: Color(0x88A1A1B2), fontWeight: FontWeight.w600, ),
               filled: true,
               fillColor: Color(0xCCEDEDF7),
            ),
         )
      );
   }
}

class SliverPersistentHeaderDlgt extends SliverPersistentHeaderDelegate {
   SliverPersistentHeaderDlgt({ 
      @required this.minHeight, @required this.maxHeight, @required this.child });

   final double minHeight; final double maxHeight; final Widget child;
   @override double get minExtent => minHeight;
   @override double get maxExtent => math.max(maxHeight, minHeight);

   @override
   Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
      return SizedBox.expand(child: child);
   }

   @override
   bool shouldRebuild(SliverPersistentHeaderDlgt oldDelegate) {
      return maxHeight != oldDelegate.maxHeight ||
         minHeight != oldDelegate.minHeight || child != oldDelegate.child;
   }
}