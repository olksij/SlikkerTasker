import 'package:tasker/reusable/slikker.dart';
import 'package:tasker/data.dart';

class AgendaBuilder extends StatefulWidget {
   final Function newItem;
   final double accent;
   final Map<String, dynamic> day;

  const AgendaBuilder({ this.newItem, this.accent, this.day });

   @override _AgendaBuilderState createState() => _AgendaBuilderState();
}

class _AgendaBuilderState extends State<AgendaBuilder> {
   @override Widget build(BuildContext context) => Column(children: _buildAgenda());

   List<Widget> _buildAgenda() {
      List<Widget> toReturn = [];
      int i = 0;
      double time = widget.day['wakeup'].hour + widget.day['wakeup'].minute/60;
      print(widget.day['projects']);
      while (i <= widget.day['projects'].length) {
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
                              color: accentColor(0.7, widget.accent, 0.2, 0.4)
                           ),
                        ),
                        Align(
                           alignment: Alignment.bottomCenter,
                           child: (i == widget.day['projects'].length) ? Text(
                              TimeOfDay(hour: time.floor()+1, minute: (time%1*60).round()).format(context),
                              style: TextStyle(
                                 color: accentColor(0.4, widget.accent, 0.2, 0.4)
                              ),
                           ) : Container(
                              height: 30,
                              width: 3,
                              decoration: BoxDecoration(
                                 color: accentColor(0.1, widget.accent, 0.2, 0.4),
                                 borderRadius: BorderRadius.circular(1.5)
                              ),
                           )
                        )
                     ],
                  ),
               ),
               Container(width: 20),
               Expanded(
                  child: i != widget.day['projects'].length 
                  ? SlikkerCard(
                     accent: 240,
                     isFloating: false,
                     padding: EdgeInsets.all(10),
                     child: Container(
                        height: 39,
                        child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                              SlikkerCard(
                                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                 accent: 240,
                                 isFloating: false,
                                 borderRadius: BorderRadius.circular(8),
                                 child: Text('PROJECT  👉'),
                                 onTap: () {},
                              ),
                              Expanded(child: Container(),),
                              SlikkerCard(
                                 accent: 240,
                                 onTap: () {},
                                 isFloating: false,
                                 borderRadius: BorderRadius.circular(8),
                                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                 child: Text('DURATION'),
                              ),
                           ],
                        )
                     ),
                  ) 
                  : SlikkerCard(
                     onTap: () => widget.newItem(),
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
                                 child: Text('Add a new thing')
                              )
                           ]
                        ),
                     )
                  )
               )
            ]
         ));
         toReturn.add(Container(height: 10,));
         if (i != widget.day['projects'].length) time += widget.day['projects'][i]['duration'] ?? 1;
         i++;
      }
      return toReturn;
   }
}
