import 'package:planner/parts.dart';
import 'slikker.dart';

class TaskPage extends StatelessWidget {
   final Map<String, dynamic> task;
   const TaskPage( this.task );

   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         title: Text('Task', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,), 
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TaskCard(task)
         ), 
         content: Text('hey..'), 
         topButtonIcon: Icons.arrow_back,
         topButtonTitle: 'Back',
         topButtonAction: () => Navigator.pushNamed(context, '/home'), 
         floatingButton: SlikkerCard(
            accent: 240,
            child: Text('edit'),
            borderRadius: BorderRadius.circular(54),
            padding: EdgeInsets.all(12),
         )
      );
   }
}