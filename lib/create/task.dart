import 'package:tasker/data.dart';
import 'package:tasker/create/types.dart';
import 'package:tasker/create/widgets.dart';

CreateType task = CreateType(
  backPath: '/home',
  props: [
    CreatePageProps(
      title: 'Title',
      description: 'The title of your task.',
      value: 'title',
      input: (Function callback) => CreatePageTextField(callback),
    ),
    CreatePageProps(
        title: 'Description',
        description: 'The description of your task.',
        value: 'description',
        input: (Function callback) => CreatePageTextField(callback)),
    CreatePageProps(
      title: 'Collection',
      description: 'Add task to collection group.',
      value: 'collection',
      input: (Function callback) {
        Map<dynamic, Map> tasks = data.toMap();
        return GridSelection(
          //scrollController: ,
          data: [
            for (String key in data.keys)
              GridSelectionData(
                title: tasks[key]?['title'] ?? 'No title',
                description: tasks[key]?['description'] ?? 'No description',
                accent: tasks[key]?['color'] ?? 240,
                callback: () => callback(key),
              )
          ],
        );
      },
    ),
    CreatePageProps(
      title: 'Time out',
      description: 'Time till which task should be done.',
      value: 'ends',
      input: () {},
    ),
  ],
);
