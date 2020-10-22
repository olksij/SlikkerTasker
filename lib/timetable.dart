import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'slikker.dart';
import 'data.dart';

class TimetablePage extends StatelessWidget {
   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pushNamed(context, '/projects'),
         title: Text('Timetable', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,),
         floatingButton: SlikkerCard(
            padding: EdgeInsets.all(17),
            child: Text('New timetable'),
            onTap: () => Navigator.push(context, MaterialPageRoute(
               builder: (context) => TimetableEditor({}),
            )),
         ),
         content: StreamBuilder(
            stream: data.watch(),
            initialData: null,
            builder: (context, snapshot){
               if (snapshot.hasError) return Text('Something went wrong');
               List<Widget> cards = [];
               Map a = data.toMap();
               a.forEach((key, value) {
                  if (key[0] == 'S') cards.add(Container());
               });
               return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, int index) => cards[index],
                  staggeredTileBuilder: (int index) =>
                     StaggeredTile.fit(1),
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
               );
            }
         ),
         header: Container(),
      );
   }
}

class TimetableEditor extends StatelessWidget {
   final Map timetable;

   const TimetableEditor(this.timetable);

   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         header: SlikkerTextField(isFloating: true, accent: 240,),
         content: Container(),
         title: Container(),
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pushNamed(context, '/timetable'),
      );
   }
}