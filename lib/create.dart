import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'material.dart';
import 'parts.dart';

class CreateView extends StatefulWidget { @override _CreateViewState createState() => _CreateViewState(); }

class _CreateViewState extends State<CreateView> {
   var pullPercent = 0;
	@override
	Widget build(BuildContext context) {
		return NotificationListener<ScrollNotification>(
         onNotification: (scrollInfo) {
            var scroll = scrollInfo.metrics.pixels.round();
            var tempPercent = scroll <= 0 ? ( scroll >= -100 ? 0-scroll : 100 ) : 0;
            if (tempPercent != pullPercent) setState(() { pullPercent = tempPercent; if (pullPercent == 100) { HapticFeedback.lightImpact(); } });
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
                     child: Layer(
                        accent: 240,
                        corningStyle: CorningStyle.full,
                        objectType: ObjectType.field,
                        padding: EdgeInsets.fromLTRB(14, 13, 17, 14),
                        child: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: <Widget>[
                              pullPercent == 0 ? 
                                 Icon(
                                    Icons.arrow_back, 
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
                              Text('Back', style: TextStyle(
                                 color: Color(0xFF1F1F33), fontWeight: FontWeight.w600, fontSize: 16
                              ))
                           ]
                        ),
                     )
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
                     child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Layer(
                           corningStyle: CorningStyle.partial, 
                           accent: 240, 
                           objectType: ObjectType.field, 
                           child: Center(
                              child: Text('Somethinggg'),
                           ),
                           padding: EdgeInsets.all(12),
                        ),
                     )
                  ),
               ),
               SliverToBoxAdapter(child: Container(height: 500),)
            ],
         )
      );
	}
}

class Create extends StatelessWidget {
	Widget build(BuildContext context) {
		return Scaffold(
         backgroundColor: Color(0xFFF7F7FC),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton: Container(
            child: Layer(
               accent: 240,
               corningStyle: CorningStyle.full,
               objectType: ObjectType.floating,
               padding: EdgeInsets.fromLTRB(14, 15, 16, 15),
               child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                     Icon(Icons.save, color: Color(0xFF6666FF),), 
                     Container(width: 7, height: 24),
                     Text('Go..!', style: TextStyle(
                        color: Color(0xFF6666FF), fontWeight: FontWeight.w600, fontSize: 16
                     ),)
                  ]
               ),
            ),
            margin: EdgeInsets.only(bottom: 14),
         ),
         body: SafeArea(
				top: true,
            child: CreateView()
			)
      );
	}
}
