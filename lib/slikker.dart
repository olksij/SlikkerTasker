import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'material.dart';

export 'package:slikker_ripple/slikker_ripple.dart';
export 'package:flutter/material.dart';
export 'material.dart';

class SlikkerScaffold extends StatefulWidget {
   final Widget title; final Widget header; final Widget content; final String topButtonTitle; 
   final IconData topButtonIcon; final Widget floatingButton; final Function topButtonAction;

   SlikkerScaffold({ this.title, this.header, this.content, 
   this.topButtonAction, this.floatingButton,this.topButtonTitle, this.topButtonIcon, });

   @override _SlikkerScaffoldState createState() => _SlikkerScaffoldState();
}

class _SlikkerScaffoldState extends State<SlikkerScaffold> {
   bool pull100; bool pullAct; bool startedAtZero; TopButton topButton;

   @override void initState() {
      super.initState();
      pull100 = false; pullAct = false;
      startedAtZero = false;
      topButton = TopButton(
         title: widget.topButtonTitle, 
         icon: widget.topButtonIcon, 
         accent: 240,
         onTap: widget.topButtonAction,
      );
   }
   
   @override Widget build(BuildContext context) {
  		return Material(
         color: Color(0xFFF6F6FC),
         child: SafeArea(
				top: true,
            child: Stack(
               children: [
                  NotificationListener<ScrollNotification>(
                     onNotification: (scrollInfo) {
                        if (scrollInfo is ScrollUpdateNotification && startedAtZero) {
                           int scroll = scrollInfo.metrics.pixels.round();
                           int percent = scroll <= 0 ? ( scroll >= -100 ? 0-scroll : 100 ) : 0;
                           if (percent == 100 && !pull100) { HapticFeedback.lightImpact(); pull100 = true; pullAct = true; }
                           if (percent != 100 && pull100) { pull100 = false; pullAct = false; }
                           if (scrollInfo is ScrollUpdateNotification && percent == 100 && scrollInfo.dragDetails == null 
                           && pullAct) { pullAct = false; widget.topButtonAction(); }
                           _topButtonState.refresh(percent);
                        } 
                        else if (scrollInfo is ScrollStartNotification) startedAtZero = scrollInfo.metrics.pixels <= 0; 
                        return true;
                     },
                     child: ListView(
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        children: <Widget>[
                           Container( height: 52 ),
                           Center( 
                              child: TopButton(
                                 title: widget.topButtonTitle, 
                                 icon: widget.topButtonIcon, 
                                 accent: 240,
                                 onTap: widget.topButtonAction,
                              ) 
                           ),
                           Container( height: MediaQuery.of(context).size.height/3.7 ),
                           widget.title, 
                           Container( height: 20 ),
                           widget.header,
                           Padding(
                              child:widget.content,
                              padding: EdgeInsets.all(30),
                           ),
                           Container(height: 60)
                        ],
                     )
                  ),
                  Align(
                     alignment: Alignment.bottomCenter,
                     child: Container(
                        decoration: BoxDecoration(
                           gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment(0,0.25),
                              colors: [ Color(0x00F6F6FC), Color(0xFFF6F6FC) ]
                           )
                        ),
                        height: 84,
                     ),
                  ),
                  Align(
                     alignment: Alignment.bottomCenter,
                     child: Container(
                        child: widget.floatingButton,
                        margin: EdgeInsets.only(bottom: 25),
                     )
                  ),
               ],
            )
			)
      );
   }
}

_TopButtonState _topButtonState;
class TopButton extends StatefulWidget {    
   final String title; final IconData icon; final double accent; final Function onTap;
   TopButton({ @required this.title, @required this.icon, @required this.accent, this.onTap });

   @override _TopButtonState createState() {  _topButtonState = _TopButtonState(); return _topButtonState; }
}

class _TopButtonState extends State<TopButton> {
   int percent = 0;
   Color color;
   bool inTree = false;
   Function onTap;

   void refresh(p) { if (percent != p && inTree) setState(() => percent = p); }
   void action(Function a) { onTap = a; print(a); }

   @override void initState() {
      super.initState();
      inTree = true;
      color = HSVColor.fromAHSV(1, widget.accent, 0.4, 0.2).toColor();
   }

   @override Widget build(BuildContext context) {
      return Layer(
         accent: 240,
         corningStyle: CorningStyle.full,
         objectType: ObjectType.field,
         onTap: this.onTap,
         padding: EdgeInsets.fromLTRB(14, 13, 17, 14),
         child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               percent == 0 ? 
                  Icon(
                     widget.icon, 
                     color: color, 
                     size: 22,
                  ) : Padding(
                     padding: EdgeInsets.all(3),
                     child: SizedBox(
                        child: CircularProgressIndicator(
                           value: percent/100,
                           strokeWidth: 3,
                           valueColor: AlwaysStoppedAnimation<Color>(color),
                        ),
                        height: 16,
                        width: 16,
                     ),
                  ),
               Container(width: 8, height: 24),
               Text(widget.title, style: TextStyle(
                  color: color, fontWeight: FontWeight.w600, fontSize: 16
               ))
            ]
         ),
      );
   }
}
