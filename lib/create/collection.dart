import 'package:flutter/widgets.dart';

import 'package:tasker/data.dart';
import 'package:tasker/create/types.dart';
import 'package:tasker/create/widgets.dart';

CreateType collection = CreateType(
  type: 'C',
  backPath: '/collections',
  props: [
    CreatePageProps(
        title: 'Title',
        description: 'The title of your collection. Required',
        value: 'title',
        input: (Function callback) => CreatePageTextField(callback)),
    CreatePageProps(
      title: 'Event',
      description:
          'Choose event, during which tasks of the collection will be suggested.',
      value: 'event',
      input: (Function callback) {
        return FutureBuilder(
          future: getCalendars(),
          builder: (BuildContext context, AsyncSnapshot<List?> snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data!;
              return GridSelection(
                //scrollController: ,
                data: [
                  for (int i = 0; i < data.length; i++)
                    GridSelectionData(
                      title: data[i].summary ?? 'No title',
                      description: data[i].description ?? 'No description',
                      accent: HSVColor.fromColor(
                        Color(int.parse(
                          data[i].backgroundColor.replaceFirst('#', ''),
                          radix: 16,
                        )),
                      ).hue,
                      callback: () => callback(data[i].id),
                    )
                ],
              );
            } else
              return Text('Please wait');
          },
        );
      },
    ),
    CreatePageProps(
      title: 'Relaxable?',
      description: 'Does it suit for break time?',
      value: 'relaxable',
      input: (a) {},
    ),
    CreatePageProps(
      title: 'Color',
      description: "Accent color for collection and it's tasks.",
      value: 'accent',
      input: (a) {},
    ),
    CreatePageProps(
      title: 'Type',
      description:
          'You do that in free time or it should be in your timetable?',
      value: 'type',
      input: (a) {},
    ),
    CreatePageProps(
      title: 'Goal',
      description: 'When collection should be marked as finished',
      value: 'goal',
      input: (a) {},
    ),
  ],
);
