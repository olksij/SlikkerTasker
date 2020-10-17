import 'slikker.dart';

class TaskCard extends StatelessWidget {
   final Map<String, dynamic> task; final Function onTap; final double accent;
   const TaskCard(this.task, { this.onTap, this.accent });

   @override Widget build(BuildContext context) {
      return SlikkerCard(
         onTap: this.onTap,
         padding: EdgeInsets.all(13),
         accent: accent ?? 240,
         borderRadius: BorderRadius.circular(12),
         child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(task['title'] ?? 'Undefined', style: TextStyle(fontSize: 18, color: Color(0xFF6666FF))),
               ),
               Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     Expanded(
                        child: Padding(padding: EdgeInsets.all(4),
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(task['description'] ?? "Hh", style: TextStyle(fontSize: 14, color: Color(0x4C6666FF))),
                                 Container(height: 0),
                                 Text(task['description'] ?? "Xx", style: TextStyle(fontSize: 14, color: Color(0x4C6666FF))),
                              ],
                           )
                        )
                     ),
                     SlikkerCard(
                        borderRadius: BorderRadius.circular(8), 
                        accent: 240, 
                        isFloating: false,
                        child: Container(
                           height: 46,
                           width: 46,
                           child: Center(
                              child: Icon(
                                 Icons.play_arrow_rounded, 
                                 color: Color(0xFF6666FF), 
                                 size: 32,
                              ),
                           ),
                        )
                     )
                  ]
               )
            ]
         ),
      );
   }
}