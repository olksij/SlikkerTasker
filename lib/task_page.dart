import 'package:tasker/reusable/info_card.dart';
import 'package:tasker/reusable/slikker.dart';
import 'package:tasker/create_page.dart';

class TaskPage extends StatelessWidget {
  final Map<String, dynamic> task;
  const TaskPage(this.task);

  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      customTitle: Text(
        'Task',
        style: TextStyle(fontSize: 36.0),
        textAlign: TextAlign.center,
      ),
      header: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: InfoCard(
            data: task,
            onCardTap: () {},
            accent: 240,
          )),
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
        borderRadius: BorderRadius.circular(54),
        padding: EdgeInsets.fromLTRB(14, 15, 16, 15),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePage(CreatePageType.task, task),
            )),
        child: Icon(
          Icons.edit_rounded,
          size: 26,
          color: Color(0xFF6666FF),
        ),
      ),
    );
  }
}
