import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'slikker.dart';
import 'parts.dart';
import 'task.dart';
import 'data.dart';

class HomePage extends StatelessWidget {
	Widget build(BuildContext context) {
      return SlikkerScaffold(
         header: SearchBar(),
         title: Text('Tasker', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,),
         topButtonIcon: Icons.account_circle_rounded,
         topButtonTitle: 'Account',
         topButtonAction: () => Navigator.pushNamed(context, '/account'),
         floatingButton: SlikkerCard(
            accent: 240,
            corningStyle: CorningStyle.full,
            objectType: ObjectType.floating,
            padding: EdgeInsets.fromLTRB(14, 15, 16, 15),
            onTap: () { Navigator.pushNamed(context, '/create'); },
            child: Row(
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                  Icon(Icons.add, color: Color(0xFF6666FF),), 
                  Container(width: 7, height: 24),
                  Text('Create', style: TextStyle(
                     color: Color(0xFF6666FF), fontWeight: FontWeight.w600, fontSize: 16
                  ))
               ]
            ),
         ),
         content: StreamBuilder(
            stream: data.watch(),
            initialData: null,
            builder: (context, snapshot){
               if (snapshot.hasError) return Text('Something went wrong');
               //if (snapshot.connectionState == ConnectionState.waiting) return Text('loading');
               
               List<Widget> cards = [];
               Map a = data.toMap();
               a.forEach((key, value) {
                  print(value);
                  cards.add(
                     TaskCard(Map<String,dynamic>.from(value), 
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                           builder: (context) => TaskPage(Map<String, dynamic>.from(value)),
                        )),
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
      );
	}
}
