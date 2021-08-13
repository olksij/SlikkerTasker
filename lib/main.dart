// Packages
import 'package:slikker_kit/slikker_kit.dart';

// Pages
import './home.dart';
import './new.dart';

void main() async {
  runApp(TaskerApp());
}

class TaskerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlikkerApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'new': (context) => NewTaskPage(),
      },
      color: Color(0xFFF6F6FC),
      theme: SlikkerThemeData(fontFamily: 'Manrope'),
      title: 'Tasker',
    );
  }
}
