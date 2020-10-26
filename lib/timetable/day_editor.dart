import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:tasker/reusable/slikker.dart';
import 'package:tasker/data.dart';
import 'package:tasker/timetable/timetable_builder.dart';

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

   void setWakeUp() => showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
   ).then((time) => setState(() => newDay['wakeup'] = time));

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
                        color: accentColor(1, widget.accent, 0.4, 0.4)
                     )),
                     Expanded(child: Container()),
                     SlikkerCard(
                        accent: 240,
                        onTap: setWakeUp,
                        isFloating: false,
                        borderRadius: BorderRadius.circular(8),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(newDay['wakeup']?.format(context) ?? 'Tap!', style: TextStyle(
                           fontSize: 15, 
                           color: accentColor(newDay['wakeup'] != null ? 1 : 0.5, widget.accent, 0.4, 0.4)
                        )),
                     ),
                  ],
               ),
            )
         ),
         content: newDay['wakeup'] == null ? SlikkerCard(
            accent: 240,
            onTap: setWakeUp,
            isFloating: false,
            child: Padding(
               padding: EdgeInsets.all(20),
               child: Text('To continue setuping your day, enter time when you wake up.', style: TextStyle(
                  fontSize: 16, 
                  color: accentColor(0.7, widget.accent, 0.4, 0.4)
               ))
            ),
         ) : AgendaBuilder(
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
                     decoration: BoxDecoration(
                        color: Color(0xFFF6F6FC),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        boxShadow: [
                           BoxShadow(
                              color: Color(0x301E1E33),
                              blurRadius: 35
                           )
                        ]
                     ),
                     padding: EdgeInsets.all(25),
                     child: DraggableScrollableSheet(
                        builder: (BuildContext context, ScrollController scrollController) { 
                           List<Widget> cards = [];
                           data.toMap().forEach((key, value) {
                              if (key[0] == 'P' || key[0] == 'P') cards.add(
                                 SlikkerCard(
                                    padding: EdgeInsets.all(15),
                                    accent: value['accent'] ?? widget.accent,
                                    child: Text(value['title'], style: TextStyle(
                                       color: accentColor(1, value['accent'] ?? widget.accent, 0.6, 1)
                                    )),
                                    isFloating: false,
                                 ),
                              );
                           });
                           return StaggeredGridView.countBuilder(
                              physics: BouncingScrollPhysics(),
                              controller: scrollController,
                              crossAxisCount: 2,
                              itemCount: cards.length,
                              itemBuilder: (BuildContext context, int index) => cards[index],
                              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                           );
                        },
                        expand: false,
                        initialChildSize: 0.4,
                        maxChildSize: 0.7,
                        minChildSize: 0.2,
                     )
                  );
               }
            ),
         ),
         title: 'Editor',
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pop(context),
      );
   }
}