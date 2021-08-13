import 'package:slikker_kit/slikker_kit.dart';

class NewTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      title: 'New task',
      topButton:
          TopButton(action: () {}, icon: SlikkerIcons.addTask, title: 'hh'),
      header: Container(),
      content: Column(
        children: [
          SlikkerButton(
            icon: IconExtended(
              SlikkerIcons.cloudUpload,
              size: 30,
            ),
            child: Text(
              'Choose tags',
              style: TextStyle(fontSize: 17),
            ),
            spacing: 16,
            onTap: () {},
            center: true,
          ),
          SizedBox(height: 24),
          SlikkerButton(
            icon: IconExtended(
              SlikkerIcons.cloudUpload,
              size: 30,
            ),
            child: Text(
              'Add to-dos',
              style: TextStyle(fontSize: 17),
            ),
            spacing: 16,
            onTap: () {},
            center: true,
          ),
          SizedBox(height: 24),
          SlikkerButton(
            icon: IconExtended(
              SlikkerIcons.cloudUpload,
              size: 30,
            ),
            child: Text(
              'Add description',
              style: TextStyle(fontSize: 17),
            ),
            spacing: 16,
            onTap: () {},
            center: true,
          ),
        ],
      ),
      floatingButton: SlikkerButton(
        icon: IconExtended(
          SlikkerIcons.addTask,
          color: Color(0xFF6F6F8F),
          backgroundColor: Color(0xFFCCCCE3),
          size: 28,
        ),
        child: Text('New'),
        padding: EdgeInsets.all(15).copyWith(right: 18),
        borderRadius: BorderRadius.circular(30),
        onTap: () {},
      ),
    );
  }
}
