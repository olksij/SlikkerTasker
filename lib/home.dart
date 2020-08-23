import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'material.dart';
import 'parts.dart';
import 'app.dart';

class HomeView extends StatelessWidget {
   final TopButton topButton = TopButton();
	@override
	Widget build(BuildContext context) {
      bool pull100 = false;
		return NotificationListener<ScrollNotification>(
         onNotification: (scrollInfo) {
            var scroll = scrollInfo.metrics.pixels.round();
            var tempPercent = scroll <= 0 ? ( scroll >= -100 ? 0-scroll : 100 ) : 0;
            topButton.refresh(tempPercent);
            if (tempPercent == 100 && !pull100) {
               HapticFeedback.lightImpact();
               pull100 = true;
            }
            if (tempPercent != 100 && pull100) pull100 = false;
            return false;
         },
         child: CustomScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
               SliverFixedExtentList( itemExtent: 50,
                  delegate: SliverChildListDelegate([Container()]),
               ),
               SliverToBoxAdapter(
                  child: Center(
                     child: topButton
                  )
               ),
               SliverFixedExtentList( itemExtent: MediaQuery.of(context).size.height/3.7,
                  delegate: SliverChildListDelegate([Container()]),
               ),
               SliverAppBar(
                  backgroundColor: Color(0xFFF7F7FC),
                  expandedHeight: 70.0,
                  flexibleSpace: FlexibleSpaceBar(  
                     collapseMode: CollapseMode.pin, 
                     background: Text('Heyheyy', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,),
                  ),
               ),
               SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverPersistentHeaderDlgt(
                     minHeight: 54.0,
                     maxHeight: 54.0,
                     child: SearchBar(),
                  ),
               ),
               SliverPadding(
                  padding: EdgeInsets.all(30),
                  sliver: StreamBuilder(
                     stream: getFirestoreData(),
                     builder: (context, snapshot){
                        if (snapshot.hasError) 
                           return SliverToBoxAdapter(child: Text('Something went wrong'));
                        if (snapshot.connectionState == ConnectionState.waiting) 
                           return SliverToBoxAdapter(child: Text('loading'));

                        List<Widget> cards = [];
                        snapshot.data.documents.forEach((d) =>
                           cards.add(
                              Container(
                                 height: 140,
                                 child: Layer(
                                    accent: 240,
                                    padding: EdgeInsets.all(20),
                                    corningStyle: CorningStyle.partial,
                                    objectType: ObjectType.floating,
                                    child: Text(d.data['appVersion'])
                                 ),
                              )
                           )
                        );
                        return SliverStaggeredGrid.countBuilder(
                           crossAxisCount: 2,
                           itemCount: cards.length,
                           itemBuilder: (BuildContext context, int index) => cards[index],
                           staggeredTileBuilder: (int index) =>
                              StaggeredTile.count(1,1),
                           mainAxisSpacing: 20.0,
                           crossAxisSpacing: 20.0,
                        );
                     }
                  ),
               ),
               //SliverToBoxAdapter(child: Container(height: 200),)
            ],
         )
      );
	}
}

class Home extends StatelessWidget {
   toCreate(context) => Navigator.pushNamed(context, '/create');
	Widget build(BuildContext context) {
		return Material(
         child: SafeArea(
				top: true,
            child: Stack(
               children: [
                  HomeView(),
                  Align(
                     alignment: Alignment.bottomCenter,
                     child: Container(
                        decoration: BoxDecoration(
                           gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment(0,0.25),
                              colors: [
                                 Color(0x00F7F7FC),
                                 Color(0xFFF7F7FC),
                              ]
                           )
                        ),
                        height: 84,
                     ),
                  ),
                  Align(
                     alignment: Alignment.bottomCenter,
                     child: Container(
                        child: Layer(
                           accent: 240,
                           corningStyle: CorningStyle.full,
                           objectType: ObjectType.floating,
                           padding: EdgeInsets.fromLTRB(14, 15, 16, 15),
                           onTap: this.toCreate,
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
   final _TopButtonState state = _TopButtonState();
   void refresh(percent) => state.refresh(percent);
   @override _TopButtonState createState() => state; 
}

class _TopButtonState extends State<TopButton> {
   var pullPercent = 0;
   void refresh(percent) => setState(() => pullPercent = percent);
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
