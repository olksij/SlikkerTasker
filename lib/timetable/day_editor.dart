import 'package:tasker/reusable/slikker.dart';

class DayEditor extends StatelessWidget {
   final Map day;
   final double accent;

   const DayEditor({ 
      this.day = const {'projects': []},
      this.accent = 240 
   });

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
                     Text('When will you wake up?', style: TextStyle(
                        fontSize: 17, 
                        color: HSVColor.fromAHSV(1, accent, 0.4, 0.4).toColor()
                     )),
                     Expanded(child: Container()),
                     SlikkerCard(
                        accent: 240,
                        isFloating: false,
                        borderRadius: BorderRadius.circular(8),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(day['wakeup'] ?? 'Tap!', style: TextStyle(
                           fontSize: 15, 
                           color: HSVColor.fromAHSV(day['wakeup'] != null ? 1 : 0.5, accent, 0.4, 0.4).toColor()
                        )),
                     ),
                  ],
               ),
            )
         ),
         content: day['wakeup'] == null ? SlikkerCard(
            accent: 240,
            isFloating: false,
            child: Padding(
               padding: EdgeInsets.all(20),
               child: Text('To continue setuping your day, enter time when you wake up.', style: TextStyle(
                  fontSize: 16, 
                  color: HSVColor.fromAHSV(0.7, accent, 0.4, 0.4).toColor()
               ))
            ),
         ) : Container(),
         title: 'Editor',
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pop(context),
      );
   }
}