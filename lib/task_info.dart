import 'slikker.dart';

class TaskDetails extends StatelessWidget {
   final String title;
   const TaskDetails({ this.title });

   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         title: Text(title, style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,), 
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Layer(
               corningStyle: CorningStyle.partial, 
               accent: 240, 
               objectType: ObjectType.field, 
               child: Center(
                  child: Text('Somethinggg'),
               ),
               padding: EdgeInsets.all(12),
            ),
         ), 
         content: SliverToBoxAdapter(child: Text('hey..')), 
         topButton: TopButton(
            accent: 240,
            icon: Icons.arrow_back,
            title: 'Back',
         ), 
         topButtonAction: () => Navigator.pushNamed(context, '/home'), 
         floatingButton: Layer(
            accent: 240,
            child: Text('edit'),
            corningStyle: CorningStyle.full,
            objectType: ObjectType.floating,
            padding: EdgeInsets.all(12),
         )
      );
   }
}