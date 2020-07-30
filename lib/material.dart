import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ripple.dart';


enum CorningStyle { partial, full }

enum ObjectType { field, floating }

class Layer extends StatefulWidget {
   final CorningStyle corningStyle; final Color accent; final int position; final Widget child; final EdgeInsetsGeometry padding;

   const Layer({ @required this.corningStyle, @required this.accent, @required this.position, @required this.child, this.padding });

   @override
   _LayerState createState() => _LayerState(corningStyle: corningStyle, accent: accent, position: position, child: child, padding: padding);
}

class _LayerState extends State<Layer> {
   final CorningStyle corningStyle; final Color accent; final int position; final Widget child; final EdgeInsetsGeometry padding;

   _LayerState({ @required this.corningStyle, @required this.accent, @required this.position, @required this.child, this.padding });

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
         margin: EdgeInsets.only(bottom: pressed ? 0 : 3, top: pressed ? 3 : 0),
         decoration: BoxDecoration(
            borderRadius: BorderRadius.circular( corningStyle.index==0 ? 12 : 26 ),
            color: Colors.white,
            boxShadow: [
               BoxShadow (
                  color: color.withSaturation(color.value-0.1).withAlpha(position*0.05 + (pressed ? 0.0 : 0.05)).toColor(),
                  offset: Offset(0, pressed ? 5 : 7),
                  blurRadius: pressed ? 30 : 40,
               ),
               BoxShadow (
                  color: color.withSaturation(color.saturation-(pressed ? 0.54 : 0.55)).toColor(),
                  offset: Offset(0,3),
               ),
            ],          
         ),
         child: ClipRRect(
            borderRadius: BorderRadius.circular( corningStyle.index==0 ? 12 : 26 ),
            child: Material(
               borderRadius: BorderRadius.circular( corningStyle.index==0 ? 12 : 26 ),
               child: InkWell(
                  splashFactory: CustomInkRipple.splashFactory,
                  splashColor: color.withAlpha(0.15).toColor(),
                  highlightColor: color.withAlpha(0.01).toColor(),
                  hoverColor: Colors.transparent,
                  onTapDown: (a) { HapticFeedback.lightImpact(); setState(() { pressed = true; }); },
                  onTapCancel: () { setState(() { pressed = false; }); },
                  onTap: () { Future.delayed(Duration(milliseconds: 200), (){setState(() {pressed=false;});}); setState(() { pressed = true; }); },
                  child: Padding(
                     padding: EdgeInsets.all( padding == null ? (corningStyle.index == 0 ? 12 : 15) : padding ),
                     child: child
                  )
               ),
            ),
         ),
      );
   }
}