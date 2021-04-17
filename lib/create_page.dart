import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/cupertino.dart';

import 'package:tasker/info_card.dart';
import 'package:tasker/slikker.dart';
import 'package:tasker/data.dart';

/// The list of props
Map<String?, dynamic>? _toCreate;

// Decides which togges will be used
enum CreatePageType { task, collection }

class CreatePage extends StatefulWidget {
  final CreatePageType pageType;
  final Map<String, dynamic> map;

  const CreatePage(this.pageType, this.map);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late List<CreateProps> _toggesList;
  late Function refreshPreviewFunction;

  void refreshPreview() => refreshPreviewFunction();

  @override
  void initState() {
    super.initState();
    _toCreate = widget.map;
    _toggesList = widget.pageType == CreatePageType.task
        ? _TaskTogges.list(refreshPreview)
        : _CollectionTogges().list(refreshPreview);
  }

  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      topButtonIcon: Icons.arrow_back,
      topButtonTitle: 'Back',
      topButtonAction: () => Navigator.pushNamed(context, widget.pageType.index == 0 ? '/home' : '/collections'),
      customTitle: Text('Create', style: TextStyle(fontSize: 36.0), textAlign: TextAlign.center),
      header: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: _CardPreview(['T', 'P'][widget.pageType.index], _toCreate,
              (Function toRefresh) => refreshPreviewFunction = toRefresh)),
      content: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        itemCount: _toggesList.length,
        itemBuilder: (BuildContext context, int index) => _toggesList[index],
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
      ),
      floatingButton: Container(),
    );
  }
}

class _CardPreview extends StatefulWidget {
  final String type;
  final Map<String?, dynamic>? data;
  final Function callback;
  const _CardPreview(this.type, this.data, this.callback);
  @override
  _CardPreviewState createState() => _CardPreviewState();
}

class _CardPreviewState extends State<_CardPreview> {
  @override
  void initState() {
    super.initState();
    widget.callback(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      data: _toCreate,
      buttonIcon: Icons.save_rounded,
      accent: 240,
      isButtonEnabled: widget.data!['title'] != null || widget.data!['description'] != null,
      onButtonTap: () {
        uploadData(widget.type, widget.data!);
        Navigator.pushNamed(context, widget.type == 'T' ? '/home' : '/collections');
      },
    );
  }
}

class CreateProps extends StatefulWidget {
  final String? title;
  final String? description;
  final String? value;
  final Function? input;
  final Function? callback;
  final Function? display;

  CreateProps({this.title, this.value, this.description, this.input, this.callback, this.display});
  @override
  _CreatePropsState createState() => _CreatePropsState();
}

class _CreatePropsState extends State<CreateProps> {
  late bool data;

  @override
  void initState() {
    super.initState();
    data = _toCreate![widget.value] != null;
  }

  enterValue() => showModalBottomSheet(
      context: context,
      isDismissible: true,
      barrierColor: Color(0x553D3D66),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            decoration: BoxDecoration(
                color: Color(0xFFF6F6FC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Color(0x301e1e33), blurRadius: 35)]),
            padding: EdgeInsets.fromLTRB(25, 25, 25, 25 + MediaQuery.of(context).viewInsets.bottom),
            child: widget.input!((newData) {
              _toCreate![widget.value] = newData;
              setState(() => data = newData != null);
              widget.callback!();
              Navigator.pop(context);
            }));
      });

  @override
  Widget build(BuildContext context) {
    return SlikkerCard(
      accent: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.display != null && _toCreate![widget.value] != null
              ? widget.display!(_toCreate![widget.value])
              : Text(_toCreate![widget.value] ?? widget.title!,
                  style: TextStyle(fontSize: 17, color: data ? Color(0xFF6666FF) : Color(0xFF3D3D66))),
          Container(height: 8),
          Text(data ? widget.title! : widget.description!,
              style: TextStyle(fontSize: 15, color: data ? Color(0x4C6666FF) : Color(0x4C3D3D66))),
        ],
      ),
      borderRadius: BorderRadius.circular(12),
      isFloating: data,
      padding: EdgeInsets.all(17),
      onTap: this.enterValue,
    );
  }
}

// Accept button in bottomModalSheet
Widget _acceptButton(Function onTap) => SlikkerCard(
    onTap: onTap,
    child: SizedBox(height: 52, width: 52, child: Center(child: Text('👍', style: TextStyle(fontSize: 18)))));

Widget _singleLineTextField(TextEditingController controller, Function pop) => SizedBox(
    height: 52,
    child: Row(children: [
      Expanded(
          child: SlikkerTextField(
        accent: 240,
        controller: controller,
        hintText: 'Type something',
      )),
      Container(width: 20),
      _acceptButton(() => pop(controller.value.text))
    ]));

// Togges used in Create Page for Task creation
class _TaskTogges {
  static TextEditingController _titleValueController = TextEditingController();
  static TextEditingController _descriptionValueController = TextEditingController();

  static List<CreateProps> list(Function callback) => [
        CreateProps(
            callback: callback,
            title: 'Title',
            description: 'The title of your task.',
            value: 'title',
            input: (Function pop) => _singleLineTextField(_titleValueController, pop)),
        CreateProps(
            callback: callback,
            title: 'Description',
            description: 'The description of your task.',
            value: 'description',
            input: (Function pop) => Column(children: [
                  SlikkerTextField(
                    accent: 240,
                    controller: _descriptionValueController,
                    hintText: 'Type something here :)',
                    maxLines: 6,
                    minLines: 3,
                  ),
                  Container(height: 20),
                  _acceptButton(() => pop(_descriptionValueController.value.text))
                ])),
        CreateProps(
          title: 'Time out',
          description: 'Time till which task should be done.',
          value: 'ends',
          input: (BuildContext context, Function refresh) => CupertinoDatePicker(
            onDateTimeChanged: (a) => print(a),
          ),
        ),
        CreateProps(title: 'Category', description: 'To which category is this task relative?', value: 'category'),
      ];
}

// Togges used in Create Page for Collection creation
class _CollectionTogges {
  static TextEditingController _titleValueController = TextEditingController();

  List<CreateProps> list(Function callback) {
    return [
      CreateProps(
          callback: callback,
          title: 'Title',
          description: 'The title of your collection. Required',
          value: 'title',
          input: (Function pop) => _singleLineTextField(_titleValueController, pop)),
      CreateProps(
        callback: callback,
        title: 'Event',
        description: 'Choose event, during which tasks of the collection will be suggested.',
        value: 'relaxable',
        input: (Function pop) {
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
                            snapshot.data![index].backgroundColor.replaceFirst('#', ''),
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
      CreateProps(
          callback: callback,
          title: 'Relaxable?',
          description: 'Does it suit for break time?',
          value: 'relaxable',
          input: (a) {}),
      CreateProps(
          callback: callback,
          title: 'Color',
          description: "Accent color for collection and it's tasks.",
          value: 'accent',
          display: (value) => Container(
                height: 10,
                //width: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [BoxShadow(blurRadius: 10, color: accentColor(0.3, value, 0.6, 1))],
                    color: accentColor(1, value, 0.6, 1)),
              ),
          input: (a) {}),
      CreateProps(
          callback: callback,
          title: 'Type',
          description: 'You do that in free time or it should be in your timetable?',
          value: 'type',
          input: (a) {}),
      CreateProps(
          callback: callback,
          title: 'Goal',
          description: 'When collection should be marked as finished',
          value: 'goal',
          input: (a) {}),
    ];
  }
}
