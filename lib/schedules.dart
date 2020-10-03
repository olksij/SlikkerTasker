import 'slikker.dart';

class SchedulesPage extends StatelessWidget {
   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pushNamed(context, '/home'),
         title: Text('Schedules', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,),
         floatingButton: SlikkerCard(
            padding: EdgeInsets.all(17),
            child: Text('new proj')
         ),
         content: Container(),
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SlikkerCard(
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