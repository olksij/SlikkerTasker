import 'package:tasker/reusable/slikker.dart';

class DayEditor extends StatefulWidget {
   final Map oldDay;
   final double accent;

   const DayEditor({ 
      this.oldDay = const {'projects': []},
      this.accent = 240 
   });

   @override _DayEditorState createState() => _DayEditorState();
}

class _DayEditorState extends State<DayEditor> {

   Map newDay;

   @override void initState() {
      super.initState();
      newDay = Map.from(widget.oldDay);
      newDay['projects'] = List.from(newDay['projects']);
   }

   List<Widget> _buildAgenda(Map day) {
      List<Widget> toReturn = [];
      int i = 0;
      double time = day['wakeup'].hour + day['wakeup'].minute/60;
      print(day['projects']);
      while (i <= day['projects'].length) {
         toReturn.add( Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Stack(
                     alignment: AlignmentDirectional.topCenter,
                     children: [
                        Text(
                           TimeOfDay(hour: time.floor(), minute: (time%1*60).round()).format(context),
                           style: TextStyle(
                              color: HSVColor.fromAHSV(0.7, widget.accent, 0.2, 0.4).toColor()
                           ),
                        ),
                        Align(
                           alignment: Alignment.bottomCenter,
                           child: (i == day['projects'].length) ? Text(
                              TimeOfDay(hour: time.floor()+1, minute: (time%1*60).round()).format(context),
                              style: TextStyle(
                                 color: HSVColor.fromAHSV(0.4, widget.accent, 0.2, 0.4).toColor()
                              ),
                           ) : Container(
                              height: 30,
                              width: 3,
                              decoration: BoxDecoration(
                                 color: HSVColor.fromAHSV(0.1, widget.accent, 0.2, 0.4).toColor(),
                                 borderRadius: BorderRadius.circular(1.5)
                              ),
                           )
                        )
                     ],
                  ),
               ),
               Container(width: 20),
               Expanded(
                  child: i != day['projects'].length 
                  ? SlikkerCard(
                     accent: 240,
                     isFloating: false,
                     padding: EdgeInsets.all(15),
                     child: Container(
                        height: 40,
                        child: Text((day['projects'][i] ?? {})['title'] ?? 'LL hey')
                     ),
                  ) 
                  : SlikkerCard(
                     onTap: () => setState(() => newDay['projects'].add({})),
                     accent: 240,
                     isFloating: false,
                     padding: EdgeInsets.all(15),
                     child: SizedBox(
                        height: 40,
                        child: Row(
                           children: [
                              Icon(Icons.add_rounded),
                              Container(width: 20),
                              Flexible(
                                 child: Text('What you gonna do at this time?')
                              )
                           ]
                        ),
                     )
                  )
               )
            ]
         ));
         toReturn.add(Container(height: 10,));
         if (i != day['projects'].length) time += day['projects'][i]['duration'] ?? 1;
         i++;
      }
      return toReturn;
   }

   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SlikkerCard(
               padding: EdgeInsets.all(10),
               isFloating: true,
               child: Row(
                  children: [
                     Container(width: 10),
                     Text('When your day starts?', style: TextStyle(
                        fontSize: 17, 
                        color: HSVColor.fromAHSV(1, widget.accent, 0.4, 0.4).toColor()
                     )),
                     Expanded(child: Container()),
                     SlikkerCard(
                        accent: 240,
                        onTap: () => showTimePicker(
                           initialTime: TimeOfDay.now(),
                           context: context,
                        ).then((time) => setState(() => newDay['wakeup'] = time)),
                        isFloating: false,
                        borderRadius: BorderRadius.circular(8),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(newDay['wakeup']?.format(context) ?? 'Tap!', style: TextStyle(
                           fontSize: 15, 
                           color: HSVColor.fromAHSV(newDay['wakeup'] != null ? 1 : 0.5, widget.accent, 0.4, 0.4).toColor()
                        )),
                     ),
                  ],
               ),
            )
         ),
         content: newDay['wakeup'] == null ? SlikkerCard(
            accent: 240,
            isFloating: false,
            child: Padding(
               padding: EdgeInsets.all(20),
               child: Text('To continue setuping your day, enter time when you wake up.', style: TextStyle(
                  fontSize: 16, 
                  color: HSVColor.fromAHSV(0.7, widget.accent, 0.4, 0.4).toColor()
               ))
            ),
         ) : Column(children: _buildAgenda(newDay)),
         title: 'Editor',
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pop(context),
      );
   }
}