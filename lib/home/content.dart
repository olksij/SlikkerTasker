import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter/material.dart';

import 'package:tasker/info_card.dart';
import 'package:tasker/task/page.dart';
import 'package:tasker/data.dart';

DateTime current = DateTime.now();
Stream<DateTime> timer =
    Stream.periodic(Duration(seconds: 60 - current.second), (i) {
  current = DateTime.now();
  return current;
}).asBroadcastStream();

class HomeSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: timer,
      builder: (context, AsyncSnapshot<DateTime> snapshot) {
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            print(index);
            return Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: _Collection(),
            );
          }),
        );
      },
    );
  }
}

class _Collection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlikkerCard(
      accent: 240,
      isFloating: false,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              children: [
                Container(
                  width: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "📚",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Homework',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '13:00',
                    style: TextStyle(
                      fontSize: 16,
                      color: HSVColor.fromAHSV(0.5, 240, 0.1, 0.7).toColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView(
              clipBehavior: Clip.none,
              padding: EdgeInsets.fromLTRB(0, 0, 15, 15),
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                for (int j = 0; j < 10; j++)
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: InfoCard(
                      isFloating: true,
                      accent: 240,
                      title: 'djkmd' + ((j + 47) * j).toString(),
                      description: 'edsdeed',
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
