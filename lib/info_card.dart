import 'package:tasker/slikker.dart';

class InfoCard extends StatelessWidget {
  final Map<String?, dynamic>? data;
  final Function? onCardTap;
  final Function? onButtonTap;
  final IconData buttonIcon;
  final double buttonIconSize;
  final bool isButtonEnabled;
  final bool showButton;
  final double? accent;
  final bool isFloating;
  const InfoCard({
    required this.data,
    this.accent,
    this.onCardTap,
    this.onButtonTap,
    this.buttonIcon = Icons.play_arrow_rounded,
    this.buttonIconSize = 32,
    this.isButtonEnabled = true,
    this.showButton = true,
    this.isFloating = true,
  });

  List<Widget> cardInfo() {
    List<Widget> more = [
      if (data!.length > 0)
        for (var i = 0; i < data!.length; i++)
          if (!['title', 'accent', 'time'].contains(data!.keys.elementAt(i)))
            Text(
              data!.values.elementAt(i) is List
                  ? data!.values.elementAt(i).join(', ')
                  : data!.values.elementAt(i),
              style: TextStyle(
                fontSize: 14,
                color: accentColor(0.4, accent!, 0.6, 1),
              ),
            ),
    ];
    return [
      Text(
        data!['title'] ?? (data!['description'] ?? 'Enter title'),
        style: TextStyle(
          fontSize: 18,
          color: accentColor(1, accent!, 0.6, 1),
        ),
      ),
      Container(height: 4),
      ...more,
      if (more.length == 0)
        Text(
          'No description',
          style: TextStyle(
            fontSize: 14,
            color: accentColor(0.4, accent!, 0.6, 1),
          ),
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SlikkerCard(
      isFloating: isFloating,
      onTap: this.onCardTap ?? () {},
      padding: EdgeInsets.all(13),
      accent: accent!,
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cardInfo(),
            ),
          ),
          if (showButton)
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
                      buttonIcon,
                      color: isButtonEnabled
                          ? accentColor(1, accent!, 0.6, 1)
                          : accentColor(0.5, accent!, 0.3, 0.5),
                      size: buttonIconSize,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
