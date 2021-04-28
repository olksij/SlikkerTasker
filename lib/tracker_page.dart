import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter/material.dart';

class TrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      topButton: TopButton(
        title: 'Back',
        icon: Icons.arrow_back,
        action: () => Navigator.pushNamed(context, '/home'),
      ),
      title: '[proj name]',
      floatingButton: SlikkerCard(
        padding: EdgeInsets.all(17),
        child: Text('start'),
        accent: 240,
      ),
      content: Container(),
      header: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SlikkerCard(
          accent: 240,
          padding: EdgeInsets.all(17),
          child: Text('in future :c'),
        ),
      ),
    );
  }
}
