import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter/material.dart';

import 'package:tasker/resources/info_card.dart';
import 'package:tasker/data/data.dart';
import 'package:tasker/create/page.dart';

class CollectionCard extends StatelessWidget {
  final String collection;
  final LocalEvent event;
  final DateTime? datetime;
  final DateTime? date;
  final Map<String, List<String>?> collectionTask;

  CollectionCard(this.collection, this.event, this.collectionTask)
      : this.datetime = event.start?.dateTime?.toLocal(),
        this.date = event.start?.date;

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
                    event.summary ?? event.description ?? 'No Title',
                    style: TextStyle(fontSize: 18),
                    softWrap: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    datetime != null
                        ? "${datetime!.hour < 10 ? "0" : ""}${datetime!.hour}:${datetime!.minute < 10 ? "0" : ""}${datetime!.minute}"
                        : "${event.start!.date!.weekday}",
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
          if (collectionTask[collection]?.length == 0)
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: SlikkerCard(
                accent: 240,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePage(CreatePageType.task, {}),
                  ),
                ),
                isFloating: true,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "There is empty right now. Add some tasks to this collection :)",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: 120,
              child: ListView.builder(
                clipBehavior: Clip.none,
                padding: EdgeInsets.fromLTRB(0, 0, 15, 15),
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: collectionTask[collection]?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: InfoCard(
                      isFloating: true,
                      accent: 240,
                      title: tasks
                          .get(collectionTask[collection]?[index])?['title'],
                      description: tasks.get(
                          collectionTask[collection]?[index])?['description'],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
