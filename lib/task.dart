import 'slikker.dart';

class TaskPage extends StatelessWidget {
   final String title; final int time;
   const TaskPage({ this.title, this.time });

   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         title: Text('Task', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,), 
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Layer(
               corningStyle: CorningStyle.partial, 
               accent: 240, 
               objectType: ObjectType.floating, 
               child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(title,),
                           Container(height: 8,),
                           Text(time.toString())
                        ],
                     )
                  ]
               ),
               padding: EdgeInsets.all(14),
            ),
         ), 
         content: Text('hey..'), 
         topButtonIcon: Icons.arrow_back,
         topButtonTitle: 'Back',
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