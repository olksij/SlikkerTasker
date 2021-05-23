import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter/material.dart';

import 'package:tasker/data/data.dart';
import 'package:tasker/home/cards.dart';

// Create stream on time change
DateTime current = DateTime.now();
Stream<DateTime> timeStream =
    Stream.periodic(Duration(seconds: 60 - current.second), (i) {
  current = DateTime.now();
  return current;
}).asBroadcastStream();

class HomeSchedule extends StatefulWidget {
  @override
  _HomeScheduleState createState() => _HomeScheduleState();
}

class _HomeScheduleState extends State<HomeSchedule> {
  late final Cache<List<LocalEvent>> events;

  @override
  void initState() {
    super.initState();
    events =
        eventsQuickly(collections.values.map<String>((e) => e['calendar']));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocalEvent>>(
      future: events.newData,
      initialData: events.cache,
      builder: (context, AsyncSnapshot<List<LocalEvent>> events) =>
          StreamBuilder(
        stream: timeStream,
        builder: (context, AsyncSnapshot<DateTime> time) {
          if (!events.hasData)
            return SliverList(
              delegate: SliverChildListDelegate([
                SlikkerCard(
                  accent: 240,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(child: Text('Loading..')),
                  ),
                ),
              ]),
            );

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if ((events.data?.length ?? 0) - 1 < index) return null;
                return Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: CollectionCard(events.data![index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
