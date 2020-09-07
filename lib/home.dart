import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'material.dart';
import 'parts.dart';
import 'app.dart';

class SlikkerPage extends StatelessWidget {
   final Widget title; final Widget header; final Widget content; final TopButton topButton; 
   final Function topButtonAction; 

   SlikkerPage({ @required this.title, @required this.header, @required this.content, 
   @required this.topButton, @required this.topButtonAction });

	@override
	Widget build(BuildContext context) {
      bool pull100 = false;
      bool pullAct = false;
		return NotificationListener<ScrollNotification>(
         onNotification: (scrollInfo) {
            int scroll = scrollInfo.metrics.pixels.round();
            int percent = scroll <= 0 ? ( scroll >= -100 ? 0-scroll : 100 ) : 0;
            if (percent == 100 && !pull100) { HapticFeedback.lightImpact(); pull100 = true; pullAct = true; }
            if (percent != 100 && pull100) { pull100 = false; pullAct = false; }
            if (scrollInfo is ScrollUpdateNotification && percent == 100 && scrollInfo.dragDetails == null 
            && pullAct) { pullAct = false; topButtonAction(); }
            topButton.refresh(percent); return false;
         },
         child: CustomScrollView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            slivers: <Widget>[
               SliverToBoxAdapter(child: Container( height: 52 )),
               SliverToBoxAdapter(child: Center( child: topButton )),
               SliverToBoxAdapter(child: Container(
                  height: MediaQuery.of(context).size.height/3.7,
               )),
               SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: 70.0,
                  flexibleSpace: FlexibleSpaceBar(  
                     collapseMode: CollapseMode.pin, 
                     background: title,
                  ),
               ),
               SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverPersistentHeaderDlgt(
                     minHeight: 54.0,
                     maxHeight: 54.0,
                     child: header,
                  ),
               ),
               SliverPadding(padding: EdgeInsets.all(30), sliver: content ),
               SliverToBoxAdapter(child: Container(height: 60))
            ],
         )
      );
	}
}

class SlikkerScaffold extends StatelessWidget {
   final Widget title; final Widget header; final Widget content; final TopButton topButton; 
   final Widget floatingButton; final Function topButtonAction;

   SlikkerScaffold({ @required this.title, @required this.header, @required this.content, 
   @required this.topButton, @required this.topButtonAction, @required this.floatingButton, });

   @override
   Widget build(BuildContext context) {
  		return Material(
         color: Color(0xFFF6F6FC),
         child: SafeArea(
				top: true,
            child: Stack(
               children: [
                  SlikkerPage(
                     content: content,
                     header: header,
                     title: title,
                     topButton: topButton,
                     topButtonAction: topButtonAction,
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

class Home extends StatelessWidget {
	Widget build(BuildContext context) {
      return SlikkerScaffold(
         header: SearchBar(),
         title: Text('Heyheyy', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,),
         topButton: TopButton(),
         topButtonAction: () => Navigator.pushNamed(context, '/account'),
         floatingButton: Layer(
            accent: 240,
            corningStyle: CorningStyle.full,
            objectType: ObjectType.floating,
            padding: EdgeInsets.fromLTRB(14, 15, 16, 15),
            onTap: () => Navigator.pushNamed(context, '/create'),
            onTapProp: context,
            child: Row(
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                  Icon(Icons.add, color: Color(0xFF6666FF),), 
                  Container(width: 7, height: 24),
                  Text('Create', style: TextStyle(
                     color: Color(0xFF6666FF), fontWeight: FontWeight.w600, fontSize: 16
                  ),)
               ]
            ),
         ),
         content: StreamBuilder(
            stream: getFirestoreData(),
            builder: (context, snapshot){
               if (snapshot.hasError) 
                  return SliverToBoxAdapter(child: Text('Something went wrong'));
               if (snapshot.connectionState == ConnectionState.waiting) 
                  return SliverToBoxAdapter(child: Text('loading'));

               List<Widget> cards = [];
               snapshot.data.docs.forEach((doc) {
                  if (doc.id != '.settings' && doc.data()['name'] != null) cards.add(
                     Layer(
                        accent: 240,
                        padding: EdgeInsets.all(20),
                        corningStyle: CorningStyle.partial,
                        objectType: ObjectType.floating,
                        child: Text(doc.data()['name'])
                     ),
                  );
               });
               return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, int index) => cards[index],
                  staggeredTileBuilder: (int index) =>
                     StaggeredTile.fit(1),
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
               );
            }
         ),
      );
	}
}

class TopButton extends StatefulWidget { 
   final _TopButtonState state = _TopButtonState();
   void refresh(percent) => state.refresh(percent);
   @override _TopButtonState createState() => state; 
}

class _TopButtonState extends State<TopButton> {
   int pullPercent = 0;
   void refresh(percent) { 
      if (pullPercent != percent) try { setState(() => pullPercent = percent); } catch (a) {} 
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
                     Icons.account_circle, 
                     color: Color(0xFF1F1F33), 
                     size: 22,
                  ) : 
                  Padding(
                     padding: EdgeInsets.all(3),
                     child: SizedBox(
                        child: CircularProgressIndicator(
                           value: pullPercent/100,
                           strokeWidth: 3,
                           valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1F1F33)),
                        ),
                        height: 16,
                        width: 16,
                     ),
                  ),
               Container(width: 8, height: 24),
               Text('Account', style: TextStyle(
                  color: Color(0xFF1F1F33), fontWeight: FontWeight.w600, fontSize: 16
               ))
            ]
         ),
      );
   }
}
