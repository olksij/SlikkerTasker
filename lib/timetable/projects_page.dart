import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:tasker/reusable/slikker.dart';
import 'package:tasker/data.dart';
import 'package:tasker/reusable/info_card.dart';
import 'package:tasker/create_page.dart';

class ProjectsPage extends StatelessWidget {
   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pushNamed(context, '/home'),
         customTitle: Text('Projects', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,),
         floatingButton: SlikkerCard(
            padding: EdgeInsets.all(17),
            child: Text('New project'),
            onTap: () => Navigator.push(context, 
               MaterialPageRoute(
                  builder: (context) => CreatePage(CreatePageType.project, {}),
               )
            ),
         ),
         content: StreamBuilder(
            stream: data.watch(),
            initialData: null,
            builder: (context, snapshot){
               if (snapshot.hasError) return Text('Something went wrong');
               List<Widget> cards = [];
               Map a = data.toMap();
               a.forEach((key, value) {
                  if (key[0] == 'P') cards.add(
                     InfoCard(data: Map<String,dynamic>.from(value), 
                        isFloating: false,
                        onCardTap: () => Navigator.push(context, 
                           MaterialPageRoute(
                              builder: (context) => CreatePage(CreatePageType.project, value),
                           )
                        ),
                        showButton: false,
                        accent: value['accent'],
                     ),
                  );
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
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SlikkerCard(
               onTap: () => Navigator.pushNamed(context, '/timetable'),
               padding: EdgeInsets.all(17),
               child: Row(
                  children: [
                     Expanded(
                        child: Column( 
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                              Text('title', style: TextStyle(fontSize: 18, color: Color(0xFF6666FF))),
                              Container(height: 4),
                              Text('Schedule which is in use', style: TextStyle(fontSize: 14, color: Color(0x4C6666FF))),
                           ]
                        ),
                     ),
                     Container(
                        child: 
                        Center(
                           child: Icon(Icons.arrow_forward_rounded, color: Color(0xAA111166),),
                        ),
                     )
                  ],
               ),
            ),
         )
      );
   }
}