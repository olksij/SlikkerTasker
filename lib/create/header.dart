import 'package:tasker/info_card.dart';
import 'package:tasker/data.dart';
import 'package:flutter/material.dart';

class CardPreview extends StatefulWidget {
  final Map<String, dynamic> initData;
  final Function callback;
  final String backPath;

  const CardPreview({
    required this.initData,
    required this.callback,
    required this.backPath,
  });

  @override
  _CardPreviewState createState() => _CardPreviewState();
}

class _CardPreviewState extends State<CardPreview> {
  late Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    data = widget.initData;
    widget.callback((Map<String, dynamic> newData) {
      this.setState(() => this.data = newData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      data: data,
      buttonIcon: Icons.save_rounded,
      accent: 240,
      isButtonEnabled: data['title'] != null || data['description'] != null,
      onButtonTap: () {
        uploadData('T', data);
        Navigator.pushNamed(context, widget.backPath);
      },
    );
  }
}
