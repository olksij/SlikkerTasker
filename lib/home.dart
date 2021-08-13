import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      title: 'Tasker',
      header: SlikkerTextField(
        borderRadius: BorderRadius.circular(12),
        controller: TextEditingController(),
        prefixWidget: Padding(
          padding: EdgeInsets.all(14),
          child: IconExtended(
            SlikkerIcons.search,
            color: Color(0xFF6F6F8F),
            backgroundColor: Color(0xFFCCCCE3),
            size: 28,
          ),
        ),
        suffixWidget: SlikkerButton(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
          icon: IconExtended(
            SlikkerIcons.settings,
            color: Color(0xFF6F6F8F),
            backgroundColor: Color(0xFFCCCCE3),
            size: 28,
          ),
          onTap: () {},
        ),
      ),
      content: Center(
        child: Text('cool'),
      ),
      floatingButton: SlikkerButton(
        icon: IconExtended(
          SlikkerIcons.addTask,
          color: Color(0xFF6F6F8F),
          backgroundColor: Color(0xFFCCCCE3),
          size: 28,
        ),
        child: Text('New'),
        padding: EdgeInsets.all(15).copyWith(right: 18),
        borderRadius: BorderRadius.circular(30),
        onTap: () => Navigator.pushNamed(context, 'new'),
      ),
    );
  }
}
