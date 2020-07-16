import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget { 
   final String title;
   final IconData icon;

  const FloatingButton({this.title, this.icon});

   @override 
   _FloatingButtonState createState() => _FloatingButtonState(title: title, icon: icon); }

class _FloatingButtonState extends State<FloatingButton> {
   double _shadowBlur;
   Color _shadowColor;
   double _positionOffsetBottom;
   Color _bottomColor;
   Offset _shadowOffset;

   final String title;
   final IconData icon;

   _FloatingButtonState({
      @required this.title,
      @required this.icon,
   });

   @override
   void initState() {
      super.initState();
      _shadowBlur = 40;
      _shadowColor = Color(0x194D4DFF);
      _positionOffsetBottom = 14;
      _bottomColor = Color(0xFFF3F3FF);
      _shadowOffset = Offset(0, 10);
   }

   void _hover(){
      setState(() {
         _shadowBlur = 30;
         _shadowColor = Color(0x154D4DFF);
         _positionOffsetBottom = 11;
         _bottomColor = Color(0xFFF0F0FF);
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
      return AnimatedContainer( 
         duration: Duration(milliseconds: 200),
         curve: Curves.easeOut,
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
               borderRadius: BorderRadius.circular(26),
               child: InkWell(
                  splashColor: Color(0x076666FF),
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTapDown: (h) { _hover();},
                  onTapCancel: () { _rest(); },
                  onTap: () { _rest(); },
                  child: Padding(
                     padding: EdgeInsets.all(15),
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
                  )
               ),
            ),
         ),
      );
   }
}