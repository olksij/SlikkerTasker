import 'package:tasker/reusable/info_card.dart';
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

   @override Widget build(BuildContext context) {
      return DraggableScrollableSheet(
         builder: chooseProjectPage,
         expand: false,
         initialChildSize: 0.4,
         maxChildSize: 0.7,
         minChildSize: 0.2,
      );
   }

   Widget chooseProjectPage(BuildContext context, ScrollController scrollController) { 
      List<Widget> cards = [];
      data.toMap().forEach((key, value) {
         if (key[0] == 'P' || key[0] == 'P') cards.add(
            InfoCard(
               data: value,
               accent: value['accent'] ?? widget.accent,
               isFloating: false,
               showButton: false,
               onCardTap: () {},
            )
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
}