import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slikker_ripple/slikker_ripple.dart';

enum CorningStyle { partial, full }
enum ObjectType { field, floating }

class Layer extends StatefulWidget {

   final CorningStyle corningStyle; final double accent; final ObjectType objectType; final Widget child; final EdgeInsetsGeometry padding; final Function onTap; final onTapProp;

   const Layer({ @required this.corningStyle, @required this.accent, @required this.objectType, @required this.child, this.padding, this.onTap, this.onTapProp });

   @override
   _LayerState createState() => _LayerState();

}

class _LayerState extends State<Layer> {

   HSVColor color;
   bool rounded;

   @override
   void initState() {
      super.initState();
      rounded = widget.corningStyle.index == 0;
      color = HSVColor.fromAHSV((widget.objectType.index == 0) ? 0.8 : 1, widget.accent, (widget.objectType.index == 0) ? 0.05 : 0.6, (widget.objectType.index == 0) ? 0.97 : 1);
   }
   
   var pressed = false;

   @override
   Widget build(BuildContext context) {
      return AnimatedContainer( 
         duration: Duration(milliseconds: 175),
         curve: Curves.easeOut,
         margin: (widget.objectType.index == 0) ? EdgeInsets.only(bottom: 1.5, top: 1.5) : EdgeInsets.only(bottom: pressed ? 0 : 3, top: pressed ? 3 : 0),
         decoration: BoxDecoration(
            borderRadius: BorderRadius.circular( rounded ? 12 : 26 ),
            color: Colors.transparent,
            boxShadow: (widget.objectType.index == 0) ? [] : [
               BoxShadow (
                  color: color.withSaturation(0.6).withAlpha(pressed ? 0.07 : 0.12).toColor(),
                  offset: Offset(0, pressed ? 5 : 7),
                  blurRadius: pressed ? 30 : 40,
               ),
               BoxShadow (
                  color: color.withSaturation(pressed ? 0.06 : 0.05).toColor(),
                  offset: Offset(0,3),
               ),
            ],          
         ),
         child: ClipRRect(
            borderRadius: BorderRadius.circular( rounded ? 12 : 26 ),
            child: Material(
               color: (widget.objectType.index == 0) ? color.toColor() : Colors.white,
               borderRadius: BorderRadius.circular( rounded ? 12 : 26 ),
               child: InkWell(
                  splashFactory: SlikkerRipple.splashFactory,
                  splashColor: color.withAlpha((widget.objectType.index == 0) ? 0.5 : 0.125).withValue((widget.objectType.index == 0) ? 0.95 : 1).withSaturation((widget.objectType.index == 0) ? 0.075 : 0.6).toColor(),
                  highlightColor: color.withAlpha(0.01).toColor(),
                  hoverColor: Colors.transparent,
                  onTapDown: (a) { HapticFeedback.lightImpact(); setState(() { pressed = true; }); },
                  onTapCancel: () { setState(() => pressed = false ); },
                  onTap: () { 
                     if ( widget.onTap != null ) widget.onTap(widget.onTapProp);
                     Future.delayed( 
                        Duration(milliseconds: 175), 
                        () => setState(() => pressed = false )
                     ); 
                     setState(() => pressed = true ); },
                  child: Padding(
                     padding: widget.padding ?? EdgeInsets.all(0),
                     child: widget.child
                  )
               ),
            ),
         ),
      );
   }
}
