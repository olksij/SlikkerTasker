import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'slikker.dart';
import 'data.dart';

Map<String, dynamic> _toCreate = {};

List<CreateProps> _toggesList = [
   CreateProps(title: 'Title', description: 'The title of your task.', value: 'title'),
   CreateProps(title: 'Description', description: 'The description of your task.', value: 'description'),
   CreateProps(title: 'Time out', description: 'Time till which task should be done.', value: 'ends'),
   CreateProps(title: 'Category', description: 'To which category is this task relative?', value: 'category'),
];

class CreatePage extends StatefulWidget { @override _CreatePageState createState() => _CreatePageState(); }

class _CreatePageState extends State<CreatePage> {
   void createEl(context) { 
      _toCreate['time'] = DateTime.now().millisecondsSinceEpoch;
      newDoc(_toCreate); 
      Navigator.pushNamed(context, '/home');
   }

   @override void initState() { super.initState(); _toCreate = {}; }

	@override
	Widget build(BuildContext context) {
      return SlikkerScaffold(
         topButtonIcon: Icons.arrow_back,
         topButtonTitle: 'Back',
         topButtonAction: () => Navigator.pushNamed(context, '/home'),
         title: Text('Create', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center),
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SlikkerCard(
               corningStyle: CorningStyle.partial, 
               accent: 240, 
               objectType: ObjectType.field, 
               child: Center(
                  child: Text('Somethinggg'),
               ),
               padding: EdgeInsets.all(12),
            ),
         ),
         content: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            itemCount: _toggesList.length,
            itemBuilder: (BuildContext context, int index) => _toggesList[index],
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
         ),
         floatingButton: SlikkerCard(
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
	final String title; final String description; final String value; 
	CreateProps({ this.title, this.value, this.description });
	@override _CreatePropsState createState() => _CreatePropsState();
}

class _CreatePropsState extends State<CreateProps> {
   TextEditingController valueController = TextEditingController();

   enterValue() => showModalBottomSheet(
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
                     SlikkerCard(
                        corningStyle: CorningStyle.partial, 
                        accent: 240, 
                        onTap: (d) { _toCreate[widget.value] = d(); this.setState(() {}); Navigator.pop(context); },
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
      bool data = _toCreate[widget.value] != null;
		return SlikkerCard(
			accent: 240,
			child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(_toCreate[widget.value] ?? widget.title, style: TextStyle(fontSize: 18, color: data ? Color(0xFF6666FF) : Color(0xFF1F1F33)),),
               Container(height: 8),
               Text(data ? widget.title : widget.description, style: TextStyle(fontSize: 14, color: data ? Color(0x4C6666FF) : Color(0x4C1F1F33))),
            ],
         ),
			corningStyle: CorningStyle.partial,
			objectType: data ? ObjectType.floating : ObjectType.field,
			padding: EdgeInsets.all(17),
			onTap: this.enterValue,
		);
	}
}
