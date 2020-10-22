import 'slikker.dart';

class TrackerPage extends StatelessWidget {
   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pushNamed(context, '/home'),
         customTitle: Text('proj name', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,),
         floatingButton: SlikkerCard(
            padding: EdgeInsets.all(17),
            child: Text('start')
         ),
         content: Container(),
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SlikkerCard(
               padding: EdgeInsets.all(17),
               child: Text('in future :c'),
            ),
         )
      );
   }
}