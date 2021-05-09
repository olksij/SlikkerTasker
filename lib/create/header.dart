import 'package:flutter/material.dart';
import 'package:slikker_kit/slikker_kit.dart';
import 'package:tasker/resources/info_card.dart';
import 'package:tasker/data/data.dart';

class CardPreview extends StatefulWidget {
  final Map<String, dynamic?> initData;
  final Function callback;
  final String backPath;
  final String type;

  const CardPreview({
    required this.initData,
    required this.callback,
    required this.backPath,
    required this.type,
  });

  @override
  _CardPreviewState createState() => _CardPreviewState();
}

class _CardPreviewState extends State<CardPreview> {
  late Map<String, dynamic?> data;

  @override
  void initState() {
    super.initState();
    data = widget.initData;
    widget.callback((Map<String, dynamic?> newData) {
      this.setState(() => this.data = newData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: data['title'],
      description: data['description'],
      accent: data['color'] ?? 240,
      isFloating: true,
      widget: Align(
        alignment: Alignment.bottomRight,
        child: SlikkerCard(
          borderRadius: BorderRadius.circular(8),
          accent: data['color'] ?? 240,
          isFloating: false,
          onTap: () {
            syncData(
              widget.type + DateTime.now().millisecondsSinceEpoch.toString(),
              data,
              local: true,
            );
            Navigator.pushNamed(context, widget.backPath);
          },
          child: Container(
            height: 46,
            width: 46,
            child: Center(
              child: Icon(
                Icons.save_rounded,
                size: 36,
                color: data['title'] != null || data['description'] != null
                    ? HSVColor.fromAHSV(1, data['color'] ?? 240, 0.6, 1)
                        .toColor()
                    : HSVColor.fromAHSV(0.5, data['color'] ?? 240, 0.3, 0.5)
                        .toColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
