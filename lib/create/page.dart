import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:tasker/create/collection.dart';
import 'package:tasker/create/header.dart';
import 'package:tasker/create/task.dart';
import 'package:tasker/create/types.dart';
import 'package:tasker/create/widgets.dart';

enum CreatePageType { task, collection }

class CreatePage extends StatefulWidget {
  final CreatePageType pageType;
  final CreateType props;
  final Map<String, dynamic> data;

  CreatePage(this.pageType, this.data)
      : props = pageType == CreatePageType.task ? task : collection;

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late Function refresh;

  @override
  void initState() {
    super.initState();
    createTemp = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      topButton: TopButton(
        icon: Icons.arrow_back,
        title: 'Back',
        action: () => Navigator.pushNamed(context, widget.props.backPath),
      ),
      title: 'Create',
      header: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: CardPreview(
          initData: widget.data,
          backPath: widget.props.backPath,
          callback: (Function function) => refresh = function,
        ),
      ),
      content: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        itemCount: widget.props.props.length,
        itemBuilder: (BuildContext context, int index) => CreatePagePropsWidget(
          config: widget.props.props[index],
          callback: refresh,
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
      ),
      floatingButton: Container(),
    );
  }
}
