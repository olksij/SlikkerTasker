import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter/material.dart';

import 'package:tasker/resources/info_card.dart';
import 'package:tasker/data/data.dart';

class CollectionCard extends StatelessWidget {
  final String id;

  CollectionCard(this.id);

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
                    collections.get(id)?['title'] ?? 'No Title',
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
            child: ListView.builder(
              clipBehavior: Clip.none,
              padding: EdgeInsets.fromLTRB(0, 0, 15, 15),
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(left: 15),
                child: InfoCard(
                  isFloating: true,
                  accent: 240,
                  title: 'djkmd' + ((index + 47) * index).toString(),
                  description: 'edsdeed',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
