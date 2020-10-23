import 'slikker.dart';

class TimetableEditor extends StatelessWidget {
   final Map timetable;
   final double accent;

   const TimetableEditor({ 
      this.timetable = const {'days': []},
      this.accent = 240 
   });

   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SlikkerCard(
               isFloating: true,
               child: Stack(
                  children:[
                     SlikkerTextField(
                        isTransperent: true,
                        accent: 240,
                        prefixIcon: Icons.text_fields_rounded,
                        prefixIconSize: 24,
                        prefixIconPadding: EdgeInsets.all(18),
                        hintText: 'Name your timetable',
                        padding: EdgeInsets.fromLTRB(18, 18, 42, 18),
                     ),
                     Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                           padding: EdgeInsets.all(7),
                           child: SlikkerCard(
                              onTap: () => Navigator.pushNamed(context, '/projects'),
                              isFloating: false,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                 width: 46,
                                 height: 46,
                                 child: Center(
                                    child: Icon(
                                       Icons.save_rounded,
                                       color: Color(0xFF6666FF)
                                    ),
                                 )
                              ),
                           ),
                        )
                     )
                  ]
               )
            )
         ),
         content: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
               for (Map day in timetable['days']) SlikkerCard(
                  accent: 240,
                  isFloating: false,
                  onTap: () {},
                  padding: EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                  child: Row(
                     children: [
                        for (Map project in day['projects']) Padding(
                           padding: EdgeInsets.symmetric(horizontal: 2),
                           child: Flexible(
                              flex: project['duration'],
                              child: Container(
                                 height: 10,
                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                              ),
                           ),
                        ),
                     ],
                  ),
               ),
               SlikkerCard(
                  isFloating: false,
                  child: Container(
                     height: 52,
                     child: Center(
                        child: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: <Widget>[
                              Icon(Icons.add, color: HSVColor.fromAHSV(0.75, accent, 0.15, 0.5).toColor(),), 
                              Container(width: 7, height: 24),
                              Text('Add new day', style: TextStyle(
                                 color: HSVColor.fromAHSV(0.75, accent, 0.15, 0.5).toColor(), 
                                 fontWeight: FontWeight.w600, 
                                 fontSize: 16
                              ))
                           ]
                        ),
                     ),
                  ),
               )
            ],
         ),
         title: 'Editor',
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pushNamed(context, '/timetable'),
      );
   }
}