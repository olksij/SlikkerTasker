import 'parts.dart';
import 'slikker.dart';

class TaskPage extends StatelessWidget {
   final Map<String, dynamic> task;
   const TaskPage( this.task );

   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         customTitle: Text('Task', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center,), 
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: InfoCard(task, onCardTap: () {},)
         ), 
         topButtonIcon: Icons.arrow_back,
         topButtonTitle: 'Back',
         topButtonAction: () => Navigator.pushNamed(context, '/home'), 
         content: SlikkerCard(
            isFloating: false,
            padding: EdgeInsets.all(15),
            child: Text(task['description'] ?? "Hh", style: TextStyle(fontSize: 15, color: Color(0xAA3D3D66))),
         ), 
         floatingButton: SlikkerCard(
            accent: 240,
            child: Text('edit'),
            borderRadius: BorderRadius.circular(54),
            padding: EdgeInsets.all(12),
         )
      );
   }
}