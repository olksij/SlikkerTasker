import 'slikker.dart';

class TimetableEditor extends StatelessWidget {
   final Map timetable;
   final double accent;

   const TimetableEditor(this.timetable, { 
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
                                       color: Color(0xFF3D3D66)
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
         content: Container(),
         title: 'Editor',
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pushNamed(context, '/timetable'),
      );
   }
}