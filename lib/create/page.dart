import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:tasker/create/collection.dart';
import 'package:tasker/create/task.dart';
import 'package:tasker/create/header.dart';
import 'package:tasker/create/widgets.dart';

enum CreatePageType { task, collection }

class CreateType {
  final String backPath;
  final List<CreatePageProps> props;

  CreateType({
    required this.backPath,
    required this.props,
  });
}

class CreatePage extends StatefulWidget {
  final CreatePageType pageType;
  final Map<String, dynamic> map;

  const CreatePage(this.pageType, this.map);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late CreateType data;
  late Function refreshPreviewFunction;

  void refreshPreview() => refreshPreviewFunction();

  @override
  void initState() {
    super.initState();
    //_toCreate = widget.map;
    if (widget.pageType == CreatePageType.task) data = task;
    if (widget.pageType == CreatePageType.collection) data = collection;
  }

  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      topButton: TopButton(
        icon: Icons.arrow_back,
        title: 'Back',
        action: () => Navigator.pushNamed(context, data.backPath),
      ),
      title: 'Create',
      header: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: CardPreview(
          'T',
          Map(),
          (Function toRefresh) => refreshPreviewFunction = toRefresh,
        ),
      ),
      content: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        itemCount: data.props.length,
        itemBuilder: (BuildContext context, int index) => CreatePagePropsWidget(
          config: data.props[index],
          callback: () {},
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
      ),
      floatingButton: Container(),
    );
  }
}
