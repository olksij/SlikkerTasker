import 'package:tasker/reusable/slikker.dart';
import 'package:tasker/main.dart';
import 'package:tasker/timetable/timetable_builder.dart';
import 'package:tasker/timetable/day_editor_additem.dart';

class DayEditor extends StatefulWidget {
  final Map<String, dynamic> oldDay;
  final double accent;

  const DayEditor({this.oldDay = const {'projects': []}, this.accent = 240});

  @override
  _DayEditorState createState() => _DayEditorState();
}

class _DayEditorState extends State<DayEditor> {
  Map<String, dynamic>? newDay;

  @override
  void initState() {
    super.initState();
    newDay = Map.from(widget.oldDay);
    newDay!['projects'] = List.from(newDay!['projects']);
  }

  void setWakeUp() => showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      ).then((time) => setState(() => newDay!['wakeup'] = time));

  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      header: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SlikkerCard(
            padding: EdgeInsets.all(10),
            isFloating: true,
            child: Row(
              children: [
                Container(width: 10),
                Text('When your day starts?',
                    style: TextStyle(fontSize: 17, color: accentColor(1, widget.accent, 0.4, 0.4))),
                Expanded(child: Container()),
                SlikkerCard(
                  accent: 240,
                  onTap: setWakeUp,
                  isFloating: false,
                  borderRadius: BorderRadius.circular(8),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(newDay!['wakeup']?.format(context) ?? 'Tap!',
                      style: TextStyle(
                          fontSize: 15,
                          color: accentColor(newDay!['wakeup'] != null ? 1 : 0.5, widget.accent, 0.4, 0.4))),
                ),
              ],
            ),
          )),
      content: newDay!['wakeup'] == null
          ? SlikkerCard(
              accent: 240,
              onTap: setWakeUp,
              isFloating: false,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('To continue setuping your day, enter time when you wake up.',
                      style: TextStyle(fontSize: 16, color: accentColor(0.7, widget.accent, 0.4, 0.4)))),
            )
          : AgendaBuilder(
              accent: 240,
              day: newDay,
              newItem: () => showModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  barrierColor: Color(0x553D3D66),
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) {
                    return Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: Color(0xFFFAFAFF),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            boxShadow: [BoxShadow(color: Color(0x301E1E33), blurRadius: 35)]),
                        child: AddItem(
                          accent: widget.accent,
                          save: (value) {
                            setState(() => newDay!['projects'].add(value));
                            Navigator.pop(context);
                          },
                          cancel: () => Navigator.pop(context),
                        ));
                  }),
            ),
      title: 'Editor',
      topButtonTitle: 'Back',
      topButtonIcon: Icons.arrow_back,
      topButtonAction: () => Navigator.pop(context),
    );
  }
}
