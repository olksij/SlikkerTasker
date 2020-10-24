import 'package:tasker/reusable/slikker.dart';

class InfoCard extends StatelessWidget {
	final Map data; 
	final Function onCardTap; 
	final Function onButtonTap; 
	final IconData buttonIcon; 
	final bool isButtonEnabled;
	final bool showButton;
	final double accent;
   final bool isFloating;
	const InfoCard(this.data, { this.onCardTap, this.onButtonTap, this.buttonIcon, this.accent = 240, this.isButtonEnabled = true, this.showButton = true, this.isFloating });

	List<Widget> cardInfo() {

		List<Widget> more = [ for (var i = 0; i < data.length; i++) 
			if (!['title', 'accent', 'time'].contains(data.keys.elementAt(i))) Text(data[i], 
            style: TextStyle(
               fontSize: 14, 
               color: HSVColor.fromAHSV(0.4, accent, 0.6, 1).toColor()
            )
         ),
		];

		return [
			Text(data['title'] ?? (data['description'] ?? 'Enter title'), 
            style: TextStyle(
               fontSize: 18, 
               color: HSVColor.fromAHSV(1, accent, 0.6, 1).toColor()
            )
         ),
			Container(height: 4),
			more.length != 0 ? more 
         : Text('No description', 
            style: TextStyle(
               fontSize: 14, 
               color: HSVColor.fromAHSV(0.4, accent, 0.6, 1).toColor()
            )
         )
		];
	}

	@override Widget build(BuildContext context) {
		return SlikkerCard(
         isFloating: isFloating ?? true,
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
							children: cardInfo()
						),
					),
					Align(
						alignment: Alignment.bottomRight,
						child: SlikkerCard(
							borderRadius: BorderRadius.circular(8), 
							accent: accent ?? 240, 
							isFloating: false,
							onTap: isButtonEnabled ? onButtonTap ?? () {} : () {},
							child: Container(
								height: 46,
								width: 46,
								child: Center(
									child: Icon(
										buttonIcon ?? Icons.play_arrow_rounded, 
										color: HSVColor.fromAHSV(isButtonEnabled ? 1 : 0.5, accent, isButtonEnabled ? 0.6 : 0.3, isButtonEnabled ? 1 : 0.5).toColor(), 
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