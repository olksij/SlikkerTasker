import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';

import 'package:tasker/data/data.dart';
import 'package:tasker/home/cards.dart';

DateTime current = DateTime.now();
Stream<DateTime> timer =
    Stream.periodic(Duration(seconds: 60 - current.second), (i) {
  current = DateTime.now();
  return current;
}).asBroadcastStream();

class CalendarEvent {
  final String calendar;
  final Event event;

  CalendarEvent(this.calendar, this.event);
}

Future<Map<String, List<Event>?>> _getEvents() async {
  Map<String, String> _collections = {};

  collections
      .toMap()
      .forEach((key, value) => _collections[value['calendar']] = key);

  return events(_collections.keys).then((value) =>
      value.map((key, value) => MapEntry(_collections[key]!, value)));
}

class HomeSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getEvents(),
      builder: (context, AsyncSnapshot<Map<String, List<Event>?>> events) =>
          StreamBuilder(
        stream: timer,
        builder: (context, AsyncSnapshot<DateTime> time) {
          if (!events.hasData)
            return SliverList(
              delegate: SliverChildListDelegate([
                SlikkerCard(
                  accent: 240,
                  child: Text('Loading..'),
                ),
              ]),
            );

          List<CalendarEvent> _collections = [];

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                while (_collections.length - 1 != index) {
                  CalendarEvent? nextEvent;

                  events.data?.forEach((key, value) {
                    if (value?.length != 0) {
                      DateTime? next = nextEvent?.event.start?.dateTime;
                      DateTime? current = value?.first.start?.dateTime;

                      if (current != null && !(next?.isAfter(current) ?? false))
                        nextEvent = CalendarEvent(key, value!.first);

                      value?.removeAt(0);
                    }
                  });

                  if (nextEvent != null)
                    _collections.add(nextEvent!);
                  else
                    return null;
                }
                return Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: CollectionCard(_collections[index].calendar),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
