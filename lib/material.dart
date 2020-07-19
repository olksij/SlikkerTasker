import 'package:flutter/material.dart';

enum LayerType{ card, fab }

class Layer extends StatefulWidget {
   final LayerType type; final Color accent; final int position; final Widget child;

   const Layer({ @required this.type, @required this.accent, @required this.position, @required this.child});

   @override
   _LayerState createState() => _LayerState(type: type, accent: accent, position: position, child: child);
}

class _LayerState extends State<Layer> {
   final LayerType type; final Color accent; final int position; final Widget child;

   _LayerState({ @required this.type, @required this.accent, @required this.position, @required this.child});

   HSVColor color;

   @override
   void initState() {
      super.initState();
      color = HSVColor.fromColor(accent);
   }
   
   var pressed = false;

   @override
   Widget build(BuildContext context) {
      return AnimatedContainer( 
         duration: Duration(milliseconds: 200),
         curve: Curves.easeOut,
         margin: EdgeInsets.only(bottom: pressed ? 0 : 3),
         decoration: BoxDecoration(
            borderRadius: BorderRadius.circular( type.index==0 ? 12 : 26 ),
            color: Colors.white,
            boxShadow: [
               BoxShadow (
                  color: color.withSaturation(color.saturation+0.1).withAlpha(pressed ? 0.1 : 0.15).toColor(),
                  offset: Offset(pressed ? 8 : 10,0),
                  blurRadius: pressed ? 30 : 40,
               ),
               BoxShadow (
                  color: color.withSaturation(color.saturation-(pressed ? 0.53 : 0.55)).toColor(),
                  offset: Offset(0,3),
                  blurRadius: 0,
               ),
            ],          
         ),
         child: ClipRRect(
            borderRadius: BorderRadius.circular( type.index==0 ? 12 : 26 ),
            child: Material(
               borderRadius: BorderRadius.circular( type.index==0 ? 12 : 26 ),
               child: InkWell(
                  splashColor: color.withAlpha(0.1).toColor(),
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTapDown: (a) { setState(() { pressed = true; }); },
                  onTapCancel: () { setState(() { pressed = false; }); },
                  onTap: () { setState(() { pressed = false; }); },
                  child: Padding(
                     padding: EdgeInsets.all( type.index == 0 ? 12 : 15 ),
                     child: child
                  )
               ),
            ),
         ),
      );
   }
}

class FloatingButton extends StatefulWidget { 
   final String title;
   final IconData icon;

   const FloatingButton({this.title, this.icon});

   @override 
   _FloatingButtonState createState() => _FloatingButtonState(title: title, icon: icon); }

class _FloatingButtonState extends State<FloatingButton> {
   final String title;
   final IconData icon;

   _FloatingButtonState({ @required this.title, @required this.icon, });

   @override
   Widget build(BuildContext context) {
      return Layer(
         accent: Color(0xFF6666FF),
         type: LayerType.fab,
         position: 1,
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