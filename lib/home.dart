import 'package:slikker_kit/slikker_kit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      title: 'Tasker',
      header: SlikkerTextField(
        controller: TextEditingController(),
      ),
      content: Center(
        child: Text('cool'),
      ),
      floatingButton: SlikkerButton(
        child: Text("Button"),
        padding: EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(26),
        onTap: () {},
      ),
    );
  }
}
