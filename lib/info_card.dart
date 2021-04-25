import 'package:tasker/slikker.dart';

class InfoCard extends StatelessWidget {
  final String? title;
  final String? description;
  final double accent;
  final Widget? widget;
  final bool? isFloating;
  final Function? onTap;

  const InfoCard({
    required this.title,
    required this.description,
    required this.accent,
    this.widget,
    this.isFloating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SlikkerCard(
      isFloating: isFloating ?? false,
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
                  title ?? description ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    color: accentColor(1, accent, 0.6, 1),
                  ),
                ),
                if (title != null && description != null) ...[
                  Container(height: 4),
                  Text(
                    title != null ? description ?? "" : "",
                    style: TextStyle(
                      fontSize: 14,
                      color: accentColor(0.4, accent, 0.6, 1),
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
