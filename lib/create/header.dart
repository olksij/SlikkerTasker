import 'package:tasker/info_card.dart';
import 'package:tasker/data.dart';
import 'package:flutter/material.dart';

class CardPreview extends StatefulWidget {
  final String type;
  final Map<String?, dynamic>? data;
  final Function callback;
  const CardPreview(this.type, this.data, this.callback);
  @override
  _CardPreviewState createState() => _CardPreviewState();
}

class _CardPreviewState extends State<CardPreview> {
  @override
  void initState() {
    super.initState();
    widget.callback(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      data: Map(),
      buttonIcon: Icons.save_rounded,
      accent: 240,
      isButtonEnabled:
          widget.data!['title'] != null || widget.data!['description'] != null,
      onButtonTap: () {
        uploadData(widget.type, widget.data!);
        Navigator.pushNamed(
            context, widget.type == 'T' ? '/home' : '/collections');
      },
    );
  }
}
