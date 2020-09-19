import 'slikker.dart';

class SearchBar extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
      return Padding(
         padding: EdgeInsets.symmetric(horizontal: 30),
         child: TextField(
            style: TextStyle(
               fontSize: 16.5,
               color: Color(0xFF1F1F33)                 
            ),
            decoration: InputDecoration(
               prefixIcon: Container(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                     Icons.search, 
                     size: 22.0, 
                     color: Color(0xFF1F1F33)
                  ),
               ),
               contentPadding: EdgeInsets.all(15),
               border: new OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
               ),
               hintText: 'Search for anything',
               hintStyle: TextStyle( color: Color(0x88A1A1B2), fontWeight: FontWeight.w600, ),
               filled: true,
               fillColor: Color(0xCCEDEDF7),
            ),
         )
      );
   }
}

class TaskCard extends StatelessWidget {
   final Map<String, dynamic> task; final Function onTap; final double accent;
   const TaskCard(this.task, { this.onTap, this.accent });

   @override Widget build(BuildContext context) {
      return SlikkerCard(
         padding: EdgeInsets.all(13),
         accent: accent ?? 240,
         child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(task['title'], style: TextStyle(fontSize: 18, color: Color(0xFF6666FF))),
               ),
               Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     Expanded(
                        child: Padding(padding: EdgeInsets.all(4),
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(task['description'] ?? "WWWWWWW", style: TextStyle(fontSize: 14, color: Color(0x4C6666FF))),
                                 Container(height: 3),
                                 Text(task['description'] ?? "WWWWWyy", style: TextStyle(fontSize: 14, color: Color(0x4C6666FF))),
                              ],
                           )
                        )
                     ),
                     SlikkerCard(
                        corningStyle: CorningStyle.partial, 
                        accent: 240, 
                        borderRadius: 8,
                        objectType: ObjectType.field, 
                        child: Container(
                           height: 46,
                           width: 46,
                           //color: Color(0xFF00FF00),
                           child: Center(
                              child: Icon(Icons.play_arrow_rounded, color: Color(0xFF6666FF), size: 32,),
                           ),
                        )
                     )
                  ]
               )
            ]
         ),
         corningStyle: CorningStyle.partial,
         objectType: ObjectType.floating,
      );
   }
}