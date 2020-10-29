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
   PageController pageController;

   initState() {
      super.initState();
      stepNumber = 0;
      pageController = PageController();
   }

   @override Widget build(BuildContext context) {
      return DraggableScrollableSheet(
         builder: (context, scrollController) => PageView(
            children: [
               chooseProjectPage(context, scrollController, pageController),
               chooseProjectPage(context, scrollController, pageController),
            ],
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
         ),
         expand: false,
         initialChildSize: 0.4,
         maxChildSize: 0.7,
         minChildSize: 0.2,
      );
   }

   Widget chooseProjectPage(BuildContext context, ScrollController scrollController, PageController pageController) { 
      List<Widget> cards = [];
      Map<String, dynamic>.from(data.toMap()).forEach((key, value) {
         if (key[0] == 'P' || key[0] == 'P') cards.add(
            InfoCard(
               data: value,
               accent: value['accent'] ?? widget.accent,
               isFloating: false,
               showButton: false,
               onCardTap: () => pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutQuart
               ),
            )
         );
      });
      return Column(
         children: [
            Text('Laaaa!',  style: TextStyle(
               fontSize: 16,
               color: accentColor(1, widget.accent, 0.3, 0.5)
            )),
            Container(height: 20,),
            Expanded(
               child: StaggeredGridView.countBuilder(
               physics: BouncingScrollPhysics(),
               controller: scrollController,
               crossAxisCount: 2,
               itemCount: cards.length,
               itemBuilder: (BuildContext context, int index) => cards[index],
               staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
               mainAxisSpacing: 20.0,
               crossAxisSpacing: 20.0,
            ))
         ]
      );
   }
}