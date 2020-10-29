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
   Map<String, dynamic> newItem;

   initState() {
      super.initState();
      stepNumber = 0;
      pageController = PageController();
      newItem = <String, dynamic>{};
   }

   @override Widget build(BuildContext context) {
      return DraggableScrollableSheet(
         builder: (context, scrollController) => PageView(
            children: [
               chooseProjectPage(context, scrollController, pageController),
               if (newItem['project'] != null && data.get(newItem['project'])['categories'] != null) chooseCategoryPage(context, scrollController, pageController),
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
      List<Widget> cards = [
         Column(
            children: [
               Text('Choose what will you do',  style: TextStyle(
                  fontSize: 17,
                  color: accentColor(1, widget.accent, 0.3, 0.5)
               )),
               Container(height: 5,),
            ],
         )
      ];
      Map<String, dynamic>.from(data.toMap()).forEach((key, value) {
         if (key[0] == 'P' || key[0] == 'P') cards.add(
            InfoCard(
               data: value,
               accent: value['accent'] ?? widget.accent,
               isFloating: false,
               showButton: false,
               onCardTap: () {
                  setState(() => newItem['project'] = key);
                  pageController.nextPage(
                     duration: Duration(milliseconds: 300),
                     curve: Curves.easeInOutQuart
                  );
               },
            )
         );
      });
      return StaggeredGridView.countBuilder(
         physics: BouncingScrollPhysics(),
         controller: scrollController,
         crossAxisCount: 2,
         itemCount: cards.length,
         itemBuilder: (BuildContext context, int index) => cards[index],
         staggeredTileBuilder: (int index) => StaggeredTile.fit(index == 0 ? 2 : 1),
         mainAxisSpacing: 20.0,
         crossAxisSpacing: 20.0,
      );
   }

   Widget chooseCategoryPage(BuildContext context, ScrollController scrollController, PageController pageController) { 
      List<Widget> cards = [
         Column(
            children: [
               Text('Choose what exactly will you do',  style: TextStyle(
                  fontSize: 17,
                  color: accentColor(1, widget.accent, 0.3, 0.5)
               )),
               Container(height: 5,),
            ],
         )
      ];
      data.get(newItem['project'])['categories'].forEach((value) {
         cards.add(
            SlikkerCard(
               accent: widget.accent,
               isFloating: false,
               padding: EdgeInsets.all(15),
               onTap: () {
                  setState(() => newItem['category'] = value);
                  pageController.nextPage(
                     duration: Duration(milliseconds: 300),
                     curve: Curves.easeInOutQuart
                  );
               },
               child: Text(
                  value, 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                     color: accentColor(1, widget.accent, 0.4, 0.4),
                     fontSize: 15
                  )
               ),
            )
         );
      });
      return StaggeredGridView.countBuilder(
         physics: BouncingScrollPhysics(),
         controller: scrollController,
         crossAxisCount: 2,
         itemCount: cards.length,
         itemBuilder: (BuildContext context, int index) => cards[index],
         staggeredTileBuilder: (int index) => StaggeredTile.fit(index == 0 ? 2 : 1),
         mainAxisSpacing: 20.0,
         crossAxisSpacing: 20.0,
      );
   }
}