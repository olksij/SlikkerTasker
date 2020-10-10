import 'slikker.dart';

class SearchBar extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
      return Padding(
         padding: EdgeInsets.symmetric(horizontal: 30),
         child: Stack(
            children:[
               TextField(
                  style: TextStyle(
                     fontSize: 16.5,
                     color: Color(0xFF3D3D66)                 
                  ),
                  decoration: InputDecoration(
                     prefixIcon: Container(
                        padding: EdgeInsets.all(17),
                        child: Icon(
                           Icons.search, 
                           size: 22.0, 
                           color: Color(0xFF3D3D66)
                        ),
                     ),
                     contentPadding: EdgeInsets.all(17),
                     border: new OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                     ),
                     hintText: 'Search for anything',
                     hintStyle: TextStyle( color: Color(0x88A1A1B2), fontWeight: FontWeight.w600, ),
                     filled: true,
                     fillColor: Color(0xCCEDEDF7),
                  ),
               ),
               Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                     padding: EdgeInsets.all(7),
                     child: SlikkerCard(
                        isFloating: false,
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                           width: 42,
                           height: 42,
                           child: Center(
                              child: Icon(
                                 Icons.person_rounded,
                                 color: Color(0xFF3D3D66)
                              ),
                           )
                        ),
                     ),
                  )
               )
            ]
         )
      );
   }
}

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
                  child: Text(task['title'], style: TextStyle(fontSize: 18, color: Color(0xFF6666FF))),
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