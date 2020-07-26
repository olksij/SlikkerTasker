import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as dev;
import 'dart:math' as math;
import 'material.dart';

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
	@override
	Widget build(BuildContext context) {
		var todo = [{'title': 'Testt'},{'title': 'Testt'},{'title': 'Testt'},{'title': 'Testt'},];
		return NotificationListener<ScrollNotification>(
         onNotification: (scrollInfo) {},
         child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
               SliverFixedExtentList( itemExtent: MediaQuery.of(context).size.height/2.75,
                  delegate: SliverChildListDelegate([ Container()]),
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
                  delegate: _SliverPersistentHeaderDelegate(
                     minHeight: 52.0,
                     maxHeight: 52.0,
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
      dev.log((MediaQuery.of(context).size.height/2.75).toString());
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

class SearchBar extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
      return Padding(
         padding: EdgeInsets.symmetric(horizontal: 30),
         child: TextField(
            style: TextStyle(
               fontSize: 16.5,
               color: Color(0xFF1F1F33)                 
            ),
            decoration: new InputDecoration(
               prefixIcon: Container(
                  padding: EdgeInsets.all(15),
                  child: new Icon( Icons.search, size: 22.0, color: Color(0xFF1F1F33)),
               ),
               contentPadding: EdgeInsets.all(17),
               border: new OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
               ),
               hintText: 'Search for anything',
               hintStyle: TextStyle( color: Color(0x88A1A1B2), fontWeight: FontWeight.w600, ),
               filled: true,
               fillColor: Color(0xCCEDEDF7),
            ),
         )
      );
   }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
   _SliverPersistentHeaderDelegate({ 
      @required this.minHeight, @required this.maxHeight, @required this.child });

   final double minHeight; final double maxHeight; final Widget child;
   @override double get minExtent => minHeight;
   @override double get maxExtent => math.max(maxHeight, minHeight);

   @override
   Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
      return SizedBox.expand(child: child);
   }

   @override
   bool shouldRebuild(_SliverPersistentHeaderDelegate oldDelegate) {
      return maxHeight != oldDelegate.maxHeight ||
         minHeight != oldDelegate.minHeight || child != oldDelegate.child;
   }
}