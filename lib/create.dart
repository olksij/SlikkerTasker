import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'slikker.dart';
import 'data.dart';

/// The list of props 
Map<String, dynamic> _toCreate;

///
Widget _acceptButton(String value, Function data, BuildContext context, Function refresh ) => SlikkerCard(
   onTap: () { 
      _toCreate[value] = data(); 
      refresh(); 
      Navigator.pop(context); 
   },
   child: SizedBox(
      height: 52,
      width: 52,
      child: Center( child: Text('👍', style: TextStyle(fontSize: 18))) 
   )
);


TextEditingController _titleValueController = TextEditingController();
List<CreateProps> _toggesList = [
   CreateProps(
      title: 'Title', 
      description: 'The title of your task.', 
      value: 'title',
      input: (BuildContext context, Function refresh) => Row(
         children: [
            Expanded(
               child: TextField(
                  controller: _titleValueController,
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
            ),
            Container(width: 20,),
            _acceptButton('title', () => _titleValueController.value.text, context, refresh)
         ]
      )
   ),
   CreateProps(
      title: 'Description', 
      description: 'The description of your task.', 
      value: 'description',
      input: (BuildContext context, Function refresh) => Column(
         children: [
            Expanded(
               child: TextField(
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  controller: _titleValueController,
                  style: TextStyle(
                     fontSize: 16.5,
                     color: Color(0xFF1F1F33)
                  ),
                  decoration: InputDecoration(
                     contentPadding: EdgeInsets.all(15),
                     border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                     ),
                     hintText: 'Type something',
                     hintStyle: TextStyle( color: Color(0x88A1A1B2), fontWeight: FontWeight.w600, ),
                     filled: true,
                     fillColor: Color(0xCCEDEDF7),
                  ),
               ),
            ),
            Container(height: 20,),
            _acceptButton('description', () => _titleValueController.value.text, context, refresh)
         ]
      )
   ),
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
               borderRadius: BorderRadius.circular(12), 
               accent: 240, 
               isFloating: false,
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
            borderRadius: BorderRadius.circular(54),
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
	final String title; final String description; final String value; final Function input;
	CreateProps({ this.title, this.value, this.description, this.input });
	@override _CreatePropsState createState() => _CreatePropsState();
}

class _CreatePropsState extends State<CreateProps> {
   bool data;
   void refresh() { setState(() => data = _toCreate[widget.value] != null); print('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');}
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
            child: widget.input(context, () { refresh(); })
         );
      }
   );

	@override Widget build(BuildContext context) {
      data = _toCreate[widget.value] != null;
		return SlikkerCard(
			accent: 240,
			child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(_toCreate[widget.value] ?? widget.title, style: TextStyle(fontSize: 17, color: data ? Color(0xFF6666FF) : Color(0xFF1F1F33)),),
               Container(height: 8),
               Text(data ? widget.title : widget.description, style: TextStyle(fontSize: 15, color: data ? Color(0x4C6666FF) : Color(0x4C1F1F33))),
            ],
         ),
         borderRadius: BorderRadius.circular(12),
			isFloating: data,
			padding: EdgeInsets.all(17),
			onTap: this.enterValue,
		);
	}
}
