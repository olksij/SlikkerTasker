import 'package:tasker/reusable/slikker.dart';
import 'package:tasker/data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AddItem extends StatefulWidget { 
   final double accent;

   const AddItem({ this.accent });

   @override _AddItemState createState() => _AddItemState(); 
}

class _AddItemState extends State<AddItem> {
   int stepNumber;

   initState() {
      super.initState();
      stepNumber = 0;
   }

   List<Widget> _projectInfo(Map project) {
      List<Widget> more = [ for (var i = 0; i < project.length; i++) 
			if (!['title', 'accent', 'time'].contains(project.keys.elementAt(i))) Text(project[i], 
            style: TextStyle(
               fontSize: 14, 
               color: accentColor(0.4, project['accent'] ?? widget.accent, 0.6, 1)
            )
         ),
		];

		return [
			Text(project['title'] ?? (project['description'] ?? 'Enter title'), 
            style: TextStyle(
               fontSize: 18, 
               color: accentColor(1, project['accent'] ?? widget.accent, 0.6, 1)
            )
         ),
			Container(height: 4),
			more.length != 0 ? more 
         : Text('No description', 
            style: TextStyle(
               fontSize: 14, 
               color: accentColor(0.4, project['accent'] ?? widget.accent, 0.6, 1)
            )
         )
		];
   }

   Widget chooseProject(BuildContext context, ScrollController scrollController) { 
      List<Widget> cards = [];
      data.toMap().forEach((key, value) {
         if (key[0] == 'P' || key[0] == 'P') cards.add(
            SlikkerCard(
               padding: EdgeInsets.all(15),
               accent: value['accent'] ?? widget.accent,
               child: Column(children: _projectInfo(value)),
               isFloating: false,
            ),
         );
      });
      return StaggeredGridView.countBuilder(
         physics: BouncingScrollPhysics(),
         controller: scrollController,
         crossAxisCount: 2,
         itemCount: cards.length,
         itemBuilder: (BuildContext context, int index) => cards[index],
         staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
         mainAxisSpacing: 20.0,
         crossAxisSpacing: 20.0,
      );
   }

   @override Widget build(BuildContext context) {
      return DraggableScrollableSheet(
         builder: chooseProject,
         expand: false,
         initialChildSize: 0.4,
         maxChildSize: 0.7,
         minChildSize: 0.2,
      );
   }
}