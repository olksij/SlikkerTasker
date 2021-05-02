import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:tasker/data.dart';
import 'package:tasker/info_card.dart';
import 'package:tasker/create/page.dart';

class CollectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      topButton: TopButton(
        title: 'Back',
        icon: Icons.arrow_back,
        action: () => Navigator.pushNamed(context, '/home'),
      ),
      title: 'Collections',
      header: Container(),
      floatingButton: SlikkerCard(
        accent: 240,
        borderRadius: BorderRadius.circular(54),
        padding: EdgeInsets.fromLTRB(14, 15, 16, 15),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreatePage(CreatePageType.collection, {}),
          ),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Icon(
            Icons.add,
            color: Color(0xFF6666FF),
          ),
          Container(width: 7, height: 24),
          Text(
            'New collection',
            style: TextStyle(
              color: Color(0xFF6666FF),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          )
        ]),
      ),
      content: StreamBuilder(
        stream: collections.watch(),
        initialData: null,
        builder: (context, AsyncSnapshot<BoxEvent?> snapshot) {
          if (snapshot.hasError) return Text('Something went wrong');
          List<Widget> cards = [];
          Map<String, dynamic> a =
              Map<String, dynamic>.from(collections.toMap());
          a.forEach((key, value) {
            //if (key[0] == 'C')
            cards.add(
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: InfoCard(
                  title: value['title'],
                  description: value['description'],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CreatePage(CreatePageType.collection, value);
                      },
                    ),
                  ),
                  accent: value['accent'] ?? 240,
                ),
              ),
            );
          });
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) => cards[index],
          );
        },
      ),
    );
  }
}
