import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:developer' as dev;

import 'material.dart';
import 'parts.dart';

void main() => runApp(Planner());

class Planner extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
         theme: ThemeData(fontFamily: 'Manrope'),
			title: 'Yaayyay',
			home: Home(),
		);
	}
}

class HomeView extends StatefulWidget { @override _HomeViewState createState() => _HomeViewState(); }

class _HomeViewState extends State<HomeView> {
   var pullPercent = 0;
	@override
	Widget build(BuildContext context) {
		var todo = [{'title': 'Testt'},{'title': 'Testt'},{'title': 'Testt'},{'title': 'Testt'},];
		return NotificationListener<ScrollNotification>(
         onNotification: (scrollInfo) {
            var scroll = scrollInfo.metrics.pixels.round();
            var tempPercent = scroll <= 0 ? ( scroll >= -100 ? 0-scroll : 100 ) : 0;
            if(tempPercent != pullPercent) setState(() { pullPercent = tempPercent; });
         },
         child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
               SliverFixedExtentList( itemExtent: MediaQuery.of(context).size.height/2.75,
                  delegate: SliverChildListDelegate([ 
                     Center(
                        child: Text(pullPercent.toString()+'%'),
                     ) 
                  ]),
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
               SliverToBoxAdapter(    
                  child: Container(
                     height: 220,
                     clipBehavior: Clip.none,
                     child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 30, bottom: 50),
                        scrollDirection: Axis.horizontal,
                        itemCount: todo.length,
                        itemBuilder: (BuildContext context, int i) {
                           return Container(
                              margin: EdgeInsets.only(right: i==todo.length-1 ? 30 : 20, left: i==0 ? 30 : 0),
                              height: 140,
                              width: 110,
                              child: Layer(
                                 accent: Color(0xFF6666FF),
                                 type: LayerType.card,
                                 position: 1,
                                 child: Container(
                                    padding: EdgeInsets.all(12), 
                                    child: Text('${todo[i]['title']} $i  ')
                                 ),
                              )
                           );
                        }
                     ),
                  )
               ), 
               SliverToBoxAdapter(child: Container(height: 200),)
            ],
         )
      );
	}
}

class Home extends StatelessWidget {
	Widget build(BuildContext context) {
      WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
			statusBarIconBrightness: Brightness.dark,
			systemNavigationBarColor: Color(0xFFF7F7FC),
			statusBarColor: Color(0x00BABADB),
		));
		return Scaffold(
         backgroundColor: Color(0xFFF7F7FC),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton: Container(
            child: FloatingButton(title: 'Create', icon: Icons.add),
            margin: EdgeInsets.only(bottom: 14),
         ),
         body: SafeArea(
				top: true,
            child: HomeView()
			)
      );
	}
}
