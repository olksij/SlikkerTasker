import 'package:flutter/widgets.dart';
import 'package:slikker_kit/slikker_kit.dart';
import 'package:tasker/slikker.dart';
import 'package:tasker/create/types.dart';
import 'package:tasker/create/widgets.dart';

CreateType task = CreateType(
  backPath: '/home',
  props: [
    CreatePageProps(
      title: 'Title',
      description: 'The title of your task.',
      value: 'title',
      input: (Function pop) => CreatePageTextField(pop),
    ),
    CreatePageProps(
      title: 'Description',
      description: 'The description of your task.',
      value: 'description',
      input: (Function pop) => Column(
        children: [
          SlikkerTextField(
            accent: 240,
            //controller: _descriptionValueController,
            hintText: 'Type something here :)',
            maxLines: 6,
            minLines: 3,
          ),
          Container(height: 20),
          CreatePageAcceptButton(() => pop('hey')),
        ],
      ),
    ),
    CreatePageProps(
      title: 'Collection',
      description: 'Add task to collection group.',
      value: 'collection',
      input: () {},
    ),
    CreatePageProps(
      title: 'Time out',
      description: 'Time till which task should be done.',
      value: 'ends',
      input: () {},
    ),
  ],
);
