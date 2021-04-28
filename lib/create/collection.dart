import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:slikker_kit/slikker_kit.dart';

import 'package:tasker/data.dart';
import 'package:slikker_kit/slikker_kit.dart';
import 'package:tasker/create/types.dart';
import 'package:tasker/create/widgets.dart';

CreateType collection = CreateType(
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
            if (snapshot.hasData)
              return StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) => SlikkerCard(
                  onTap: () => callback(snapshot.data![index].id),
                  accent: HSVColor.fromColor(Color(int.parse(
                    snapshot.data![index].backgroundColor.replaceFirst('#', ''),
                    radix: 16,
                  ))).hue,
                  isFloating: false,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    snapshot.data![index].summary ?? 'Title',
                    style: TextStyle(
                      color: Color(
                        int.parse(
                          snapshot.data![index].backgroundColor
                              .replaceFirst('#', ''),
                          radix: 16,
                        ),
                      ).withAlpha(255),
                    ),
                  ),
                ),
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              );
            else
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
