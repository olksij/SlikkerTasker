import 'slikker.dart';

class TaskCard extends StatelessWidget {
   final Map<String, dynamic> task; 
   final Function onCardTap; 
   final Function onButtonTap; 
   final IconData buttonIcon; 
   final bool isButtonEnabled;
   final double accent;
   const TaskCard(this.task, { this.onCardTap, this.onButtonTap, this.buttonIcon, this.accent = 240, this.isButtonEnabled = true });

   @override Widget build(BuildContext context) {
      return SlikkerCard(
         onTap: this.onCardTap ?? () {},
         padding: EdgeInsets.all(13),
         accent: accent ?? 240,
         borderRadius: BorderRadius.circular(12),
         child: Stack( 
            alignment: Alignment.bottomRight,
            children: [
               Padding(
                  padding: EdgeInsets.all(4),
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text(task['title'] ?? (task['description'] ?? 'Enter title'), style: TextStyle(fontSize: 18, color: Color(0xFF6666FF))),
                        Container(height: 4),
                        Text(task['description'] ?? "Nothing to show", style: TextStyle(fontSize: 14, color: Color(0x4C6666FF))),
                        Text(task['project'] ?? "Nothing to show", style: TextStyle(fontSize: 14, color: Color(0x4C6666FF))),
                     ],
                  ),
               ),
               Align(
                  alignment: Alignment.bottomRight,
                  child: SlikkerCard(
                     borderRadius: BorderRadius.circular(8), 
                     accent: 240, 
                     isFloating: false,
                     onTap: isButtonEnabled ? onButtonTap ?? () {} : () {},
                     child: Container(
                        height: 46,
                        width: 46,
                        child: Center(
                           child: Icon(
                              buttonIcon ?? Icons.play_arrow_rounded, 
                              color: Color(isButtonEnabled ? 0xFF6666FF : 0x886666FF), 
                              size: buttonIcon != null ? 28 : 32,
                           ),
                        ),
                     )
                  ),
               )
            ]
         ),
      );
   }
}