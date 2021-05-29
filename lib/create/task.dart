import 'package:tasker/data/data.dart';
import 'package:tasker/create/types.dart';
import 'package:tasker/create/widgets.dart';

CreateType task = CreateType(
  type: 'T',
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
        return GridSelection(
          //scrollController: ,
          data: [
            for (String key in collections.keys)
              GridSelectionData(
                title: collections.get(key)?['title'] ?? 'No title',
                description:
                    collections.get(key)?['description'] ?? 'No description',
                accent: collections.get(key)?['color'] ?? 240,
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
