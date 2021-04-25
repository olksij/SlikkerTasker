import 'package:tasker/slikker.dart';

class InfoCard extends StatelessWidget {
  final String? title;
  final String? description;
  final double accent;
  final Widget? widget;
  final bool isFloating;
  final Function? onTap;

  const InfoCard({
    required this.title,
    required this.description,
    required this.accent,
    this.isFloating = false,
    this.widget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SlikkerCard(
      isFloating: isFloating,
      onTap: onTap ?? () {},
      padding: EdgeInsets.all(13),
      accent: accent,
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? description ?? "No title.",
                  style: TextStyle(
                    fontSize: 18,
                    color: isFloating
                        ? accentColor(1, accent, .6, 1)
                        : accentColor(.8, accent, .25, .3),
                  ),
                ),
                if (title != null && description != null) ...[
                  Container(height: 4),
                  Text(
                    title != null ? description ?? "" : "",
                    style: TextStyle(
                      fontSize: 14,
                      color: isFloating
                          ? accentColor(.4, accent, .6, 1)
                          : accentColor(.4, accent, .25, .3),
                    ),
                  ),
                ],
              ],
            ),
          ),
          widget ?? Container(),
        ],
      ),
    );
  }
}
