import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'app_icons.dart';

import 'slikker.dart';
import 'parts.dart';
import 'task.dart';
import 'data.dart';

class HomePage extends StatelessWidget {
	Widget build(BuildContext context) {
      return SlikkerScaffold(
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Stack(
               children:[
                  SlikkerTextField(
                     accent: 240,
                     prefixIcon: Icons.search,
                     hintText: 'Search everything',
                     padding: EdgeInsets.fromLTRB(15, 15, 42, 15),
                  ),
                  Align(
                     alignment: Alignment.centerRight,
                     child: Padding(
                        padding: EdgeInsets.all(7),
                        child: SlikkerCard(
                           onTap: () => Navigator.pushNamed(context, '/timeline'),
                           isFloating: false,
                           borderRadius: BorderRadius.circular(6),
                           child: Container(
                              width: 42,
                              height: 42,
                              child: Center(
                                 child: Icon(
                                    AppIcons.timeline,
                                    color: Color(0xFF3D3D66)
                                 ),
                              )
                           ),
                        ),
                     )
                  )
               ]
            )
         ),
         title: Text('Tasker', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,),
         topButtonIcon: Icons.account_circle_rounded,
         topButtonTitle: 'Account',
         topButtonAction: () => Navigator.pushNamed(context, '/account'),
         floatingButton: SlikkerCard(
            accent: 240,
            borderRadius: BorderRadius.circular(54),
            padding: EdgeInsets.fromLTRB(14, 15, 16, 15),
            onTap: () { Navigator.pushNamed(context, '/createTask'); },
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
         content: Column(
            children: [
               _ConnectivityStatus(),
               StreamBuilder(
                  stream: data.watch(),
                  initialData: null,
                  builder: (context, snapshot){
                     if (snapshot.hasError) return Text('Something went wrong');
                     List<Widget> cards = [];
                     Map a = data.toMap();
                     a.forEach((key, value) {
                        if (key != '.settings') cards.add(
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
               )
            ]
         )
      );
	}
}

class _ConnectivityStatus extends StatefulWidget {
  @override 
  __ConnectivityStatusState createState() => __ConnectivityStatusState();
}

class __ConnectivityStatusState extends State<_ConnectivityStatus> {
   String connectivity = '';

   @override void initState() {
      super.initState();
      connectivityStatusRefresher = refresh;
      connectivity = connectivityStatus;
   }

   void refresh(String status) => setState(() => connectivity = status);

   @override Widget build(BuildContext context) {
      return connectivity != '' ? 
      Column(
         children: [
            Flex(
               direction: Axis.horizontal,
               children: [
                  Expanded(
                     child: SlikkerCard(
                        isFloating: false,
                        padding: EdgeInsets.all(15),
                        child: Center(
                           child: Text(connectivity,),
                        )
                     ),
                  )
               ],
            ),
            
            Container(height: 30,)
         ]
      ) : Container();
   }
}
