import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'slikker.dart';
import 'parts.dart';
import 'app.dart';

String name;

class CreateView extends StatefulWidget { @override _CreateViewState createState() => _CreateViewState(); }

class _CreateViewState extends State<CreateView> {
   
   void createEl(context) { 
      newDoc({'name': name, 'time': DateTime.now().millisecondsSinceEpoch }); 
      Navigator.pushNamed(context, '/home');
   }

	var pullPercent = 0;
	var toggesList = [
		{ 'title': 'name', 'value': name },
		{ 'title': 'name', 'value': null },
		{ 'title': 'name', 'value': null },
		{ 'title': 'name', 'value': null },
	];
	@override
	Widget build(BuildContext context) {
      return SlikkerScaffold(
         topButton: TopButton(),
         topButtonAction: () => Navigator.pushNamed(context, '/home'),
         title: Text('Heyheyy', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center),
         header: Padding(
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
         ),
         content: SliverStaggeredGrid.countBuilder(
            crossAxisCount: 2,
            itemCount: toggesList.length,
            itemBuilder: (BuildContext context, int index) => CreateProps(
               title: toggesList[index]['title'],
               value: toggesList[index]['value'],
            ),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
         ),
         floatingButton: Layer(
            accent: 240,
            corningStyle: CorningStyle.full,
            objectType: ObjectType.floating,
            padding: EdgeInsets.fromLTRB(14, 15, 16, 15),
            onTap: this.createEl,
            onTapProp: context,
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
      );
   }
}

class CreateProps extends StatefulWidget {
	final String title; final String value;
	const CreateProps({Key key, this.title, this.value});
	@override _CreatePropsState createState() => _CreatePropsState();
}

class _CreatePropsState extends State<CreateProps> {
   TextEditingController valueController = TextEditingController();

   String value;

   initState() {
      super.initState();
   }

   enterValue(a) => showModalBottomSheet(
      context: context, 
      isDismissible: true,
      barrierColor: Color(0x551F1F33),
      backgroundColor: Colors.transparent,
      builder: (context) { 
         return Container(
            decoration: BoxDecoration(
               color: Color(0xFFF6F6FC),
               borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
               boxShadow: [
                  BoxShadow(
                     color: Color(0x301e1e33),
                     blurRadius: 35
                  )
               ]
            ),
            padding: EdgeInsets.fromLTRB(25, 25, 25, 25 + MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
               height: 55,
               child: Row(
                  children: [
                     Expanded(
                        child: Container(
                           margin: EdgeInsets.only(bottom: 3),
                           child: TextField(
                              controller: valueController,
                              style: TextStyle(
                                 fontSize: 16.5,
                                 color: Color(0xFF1F1F33)
                              ),
                              decoration: InputDecoration(
                                 contentPadding: EdgeInsets.all(15),
                                 border: new OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12),
                                 ),
                                 hintText: 'Type something',
                                 hintStyle: TextStyle( color: Color(0x88A1A1B2), fontWeight: FontWeight.w600, ),
                                 filled: true,
                                 fillColor: Color(0xCCEDEDF7),
                              ),
                           ),
                        )
                     ),
                     Container(width: 20,),
                     Layer(
                        corningStyle: CorningStyle.partial, 
                        accent: 240, 
                        onTap: (d) { name = d(); Navigator.pop(context); },
                        onTapProp: () => valueController.value.text,
                        objectType: ObjectType.floating, 
                        child: SizedBox(
                           height: 52,
                           width: 52,
                           child: Center(
                              child: Text('👍', style: TextStyle(fontSize: 18),)
                           ) 
                        )
                     )
                  ]
               )
            )
         );
      }
   );

	@override
	Widget build(BuildContext context) {
		return Layer(
			accent: 240,
			child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Text(widget.title),
               widget.value != null ? Text(widget.value) : Container(),
            ],
         ),
			corningStyle: CorningStyle.partial,
			objectType: widget.value != null ? ObjectType.floating : ObjectType.field,
			padding: EdgeInsets.all(15),
			onTap: this.enterValue,
         onTapProp: 'a'
		);
	}
}

class Create extends StatelessWidget {
   void createEl(context) { 
      newDoc({'name': name, 'time': DateTime.now().millisecondsSinceEpoch }); 
      Navigator.pushNamed(context, '/home');
   }

   @override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Color(0xFFF6F6FC),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
			floatingActionButton: Container(
				child: Layer(
					accent: 240,
					corningStyle: CorningStyle.full,
					objectType: ObjectType.floating,
					padding: EdgeInsets.fromLTRB(14, 15, 16, 15),
               onTap: this.createEl,
               onTapProp: context,
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
