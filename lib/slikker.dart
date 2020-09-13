import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'material.dart';

export 'package:slikker_ripple/slikker_ripple.dart';
export 'package:flutter/material.dart';
export 'material.dart';

class SlikkerScaffold extends StatelessWidget {
   final Widget title; final Widget header; final Widget content; final TopButton topButton; 
   final Widget floatingButton; final Function topButtonAction;

   SlikkerScaffold({ @required this.title, @required this.header, @required this.content, 
   @required this.topButton, @required this.topButtonAction, @required this.floatingButton, });

   @override
   Widget build(BuildContext context) {
      bool pull100 = false;
      bool pullAct = false;
      bool startedAtZero = false;
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
                           && pullAct) { pullAct = false; topButtonAction(); }
                           topButton.refresh(percent); 
                        } 
                        else if (scrollInfo is ScrollStartNotification) startedAtZero = scrollInfo.metrics.pixels <= 0; 
                        return false;
                     },
                     child: CustomScrollView(
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        slivers: <Widget>[
                           SliverToBoxAdapter(child: Container( height: 52 )),
                           SliverToBoxAdapter(child: Center( child: topButton )),
                           SliverToBoxAdapter(child: Container( height: MediaQuery.of(context).size.height/3.7 )),
                           SliverToBoxAdapter(child: title),
                           SliverAppBar(
                              elevation: 0,
                              floating: true,
                              pinned: true,
                              titleSpacing: 0,
                              title: header,
                              backgroundColor: Colors.transparent,
                              automaticallyImplyLeading: false,
                           ),
                           SliverPadding(padding: EdgeInsets.all(30), sliver: content ),
                           SliverToBoxAdapter(child: Container(height: 60))
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
                        child: floatingButton,
                        margin: EdgeInsets.only(bottom: 25),
                     )
                  ),
               ],
            )
			)
      );
   }
}

class TopButton extends StatefulWidget { 
   final String title; final IconData icon; final double accent;
   final _TopButtonState state = _TopButtonState();
   TopButton({ @required this.title, @required this.icon, @required this.accent });
   void refresh(percent) => state.refresh(percent);
   @override _TopButtonState createState() => state; 
}

class _TopButtonState extends State<TopButton> {
   int pullPercent = 0;
   Color color;
   bool inTree = false;
   void refresh(percent) { 
      if (pullPercent != percent && inTree) setState(() => pullPercent = percent); 
   }
   @override
   void initState() {
      super.initState();
      inTree = true;
      color = HSVColor.fromAHSV(1, widget.accent, 0.4, 0.2).toColor();
   }
   @override Widget build(BuildContext context) {
      return Layer(
         accent: 240,
         corningStyle: CorningStyle.full,
         objectType: ObjectType.field,
         padding: EdgeInsets.fromLTRB(14, 13, 17, 14),
         child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               pullPercent == 0 ? 
                  Icon(
                     widget.icon, 
                     color: color, 
                     size: 22,
                  ) : Padding(
                     padding: EdgeInsets.all(3),
                     child: SizedBox(
                        child: CircularProgressIndicator(
                           value: pullPercent/100,
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
