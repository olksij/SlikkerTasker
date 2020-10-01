import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slikker_ripple/slikker_ripple.dart';

export 'package:slikker_ripple/slikker_ripple.dart';
export 'package:flutter/material.dart';

/// Widget that helps to build a page. 
/// Full documentation be later
class SlikkerScaffold extends StatefulWidget {
   /// Widget that is displayed on top of `header`. Useally is a text which indicates which page is it. In Material design it wuld be `AppBarTitle`
   final Widget title; 

   /// Widget that is displayed on top of `content`. In Material Design it would be the `AppBar`.
   final Widget header; 

   /// Widget, usually `ListView`/`GridView` that contains other widgets. Content of the page.
   final Widget content; 

   /// `TopButton`'s title. Usually text that hints which action will be taken when user taps the button or pulls the page.
   final String topButtonTitle; 

   /// `TopButton`'s icon. Usually used for hinting which action will be taken when user taps the button or pulls the page.
   final IconData topButtonIcon; 

   /// The function that will be called when user pulls the page or taps the `TopButton`.
   final Function topButtonAction;
   
   /// Widget that is placed in the bottom of the screen, always visible, and floats above the `content`.
   final Widget floatingButton; 

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

   void refresh(p) { if (percent != p && inTree) setState(() => percent = p); }

   @override void initState() {
      super.initState();
      inTree = true;
      color = HSVColor.fromAHSV(1, widget.accent, 0.4, 0.2).toColor();
   }

   @override Widget build(BuildContext context) {
      return SlikkerCard(
         accent: 240,
         borderRadius: BorderRadius.circular(52),
         isFloating: false,
         onTap: this.widget.onTap,
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





class SlikkerCard extends StatefulWidget {
   /// The Hue which will be used for your card.
   final double accent; 
   /// If `true` *[DEFAULT]*, your widget gets shadows, pressing-like tap feedback, and z-axis.
   final bool isFloating; 
   /// Decides how curved will be sides of your card. Default is `BorderRadius.all(Radius.circular(12))`
   final BorderRadiusGeometry borderRadius; 
   final Widget child; 
   final EdgeInsetsGeometry padding; 
   /// The `Function` that will be invoked on user's tap.
   final Function onTap; 
   /// Parameters that will be used for function if needed.
   final dynamic onTapProp;

   @override _SlikkerCardState createState() => _SlikkerCardState();

   SlikkerCard({ 
      this.accent = 240, 
      this.isFloating = true, 
      this.child = const Text('hey?'), 
      this.padding = const EdgeInsets.all(0), 
      this.onTap, 
      this.onTapProp, 
      this.borderRadius = const BorderRadius.all(Radius.circular(12)),
   });
}

class _SlikkerCardState extends State<SlikkerCard> with TickerProviderStateMixin{

   HSVColor color;
   bool pressed;
   AnimationController tapOffsetController;
   Offset tapOffset = Offset(0, 0);
   CurvedAnimation tapOffsetAnimation;

   @override void initState() {
      super.initState();
      pressed = false;
      color = HSVColor.fromAHSV(
         widget.isFloating ? 1 : 0.075, 
         widget.accent, 
         widget.isFloating ? 0.6 : 0.3, 
         widget.isFloating ? 1 : 0.75
      );

      tapOffsetController = AnimationController(
         vsync: this,
         duration: Duration(milliseconds: 175),
      );

      tapOffsetAnimation = CurvedAnimation(
         curve: Curves.easeOut,
         parent: tapOffsetController
      );
      
      tapOffsetAnimation.addListener(() => setState(() {}));
   }

   @override void dispose() {
      tapOffsetController.dispose();
      super.dispose();
   }

   @override Widget build(BuildContext context) {
      return AnimatedContainer( 
         duration: Duration(milliseconds: 175),
         curve: Curves.easeOut,
         decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            color: Colors.transparent,
            boxShadow: widget.isFloating ? [
               BoxShadow (
                  color: color.withSaturation(0.6).withAlpha(pressed ? 0.07 : 0.12).toColor(),
                  offset: Offset(0, pressed ? 5 : 7),
                  blurRadius: pressed ? 30 : 40,
               ),
               BoxShadow (
                  color: color.withSaturation(pressed ? 0.06 : 0.05).toColor(),
                  offset: Offset(0,3),
               ),
            ] : [],          
         ),
         child: Transform.translate(
            offset: Offset(0, widget.isFloating ? tapOffsetAnimation.value*3 : 0),
            child: Material(
               clipBehavior: Clip.hardEdge,
               color: widget.isFloating ? Colors.white : color.toColor(),
               borderRadius: widget.borderRadius,
               child: InkWell(
                  splashFactory: SlikkerRipple(),
                  splashColor: color.withAlpha(widget.isFloating ? 0.125 : 0.25)
                     .withValue(widget.isFloating ? 1 : 0.85)
                     .withSaturation(widget.isFloating ? 0.6 : 0.15)
                     .toColor(),
                  highlightColor: color.withAlpha(0.01).toColor(),
                  hoverColor: Colors.transparent,
                  onTapDown: (a) { 
                     HapticFeedback.lightImpact(); 
                     tapOffsetController.forward();
                     setState(() { pressed = true; }); 
                  },
                  onTapCancel: () { 
                     setState(() => pressed = false ); 
                     tapOffsetController.reverse();
                  },
                  onTap: () { 
                     if (widget.onTap != null) {
                        widget.onTapProp != null 
                        ? widget.onTap(widget.onTapProp) 
                        : widget.onTap();
                     }

                     Future.delayed( 
                        Duration(milliseconds: 175), () { 
                           setState(() => pressed = false);
                           tapOffsetController.reverse(from: 1);
                        }
                     ); 

                     setState(() => pressed = true); 
                  },
                  child: Padding(
                     padding: widget.padding,
                     child: widget.child
                  )
               ),
            ),
         )
      );
   }
}
