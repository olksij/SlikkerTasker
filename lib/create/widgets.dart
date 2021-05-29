import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:slikker_kit/slikker_kit.dart';

import 'package:tasker/resources/info_card.dart';
import 'package:tasker/create/types.dart';

Map<String?, dynamic> createTemp = {};

// --- ACCEPT BUTTON --- ///

class CreatePageAcceptButton extends StatelessWidget {
  final Function onTap;

  CreatePageAcceptButton(this.onTap);

  @override
  Widget build(BuildContext context) {
    return SlikkerCard(
      onTap: onTap,
      accent: 240,
      child: SizedBox(
        height: 52,
        width: 52,
        child: Center(
          child: Text('👍', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

// --- TEXT FIELD --- ///

class CreatePageTextField extends StatefulWidget {
  final Function callback;

  CreatePageTextField(this.callback);

  @override
  _CreatePageTextFieldState createState() => _CreatePageTextFieldState();
}

class _CreatePageTextFieldState extends State<CreatePageTextField> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          Expanded(
            child: SlikkerTextField(
              accent: 240,
              controller: controller,
              hintText: 'Type something',
            ),
          ),
          Container(width: 20),
          CreatePageAcceptButton(() => widget.callback(controller.value.text))
        ],
      ),
    );
  }
}

// --- GRID SELECTION WIDGET --- ///

class GridSelectionData {
  final String title;
  final String description;
  final double accent;
  final Function callback;

  GridSelectionData({
    required this.title,
    required this.description,
    required this.accent,
    required this.callback,
  });
}

class GridSelection extends StatelessWidget {
  final List<GridSelectionData> data;
  final ScrollController? scrollController;

  const GridSelection({
    required this.data,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      itemCount: data.length,
      controller: scrollController,
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 25.0,
      crossAxisSpacing: 25.0,
      itemBuilder: (BuildContext context, int index) => InfoCard(
        onTap: data[index].callback,
        accent: data[index].accent,
        isFloating: true,
        title: data[index].title,
        description: data[index].description,
      ),
    );
  }
}

// --- PROPS WIDGET --- ///

class CreatePagePropsWidget extends StatefulWidget {
  final CreatePageProps config;
  final Function callback;

  CreatePagePropsWidget({required this.config, required this.callback});

  @override
  _CreatePagePropsWidgetState createState() => _CreatePagePropsWidgetState();
}

class _CreatePagePropsWidgetState extends State<CreatePagePropsWidget> {
  late bool isEmpty;

  @override
  void initState() {
    super.initState();
    isEmpty = createTemp[widget.config.value] == null;
  }

  processData(newData) {
    setState(() {
      createTemp[widget.config.value] = newData;
      isEmpty = createTemp[widget.config.value] == null;
    });
    Navigator.pop(context);
    widget.callback(Map<String, dynamic>.from(createTemp));
  }

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: isEmpty ? widget.config.title : createTemp[widget.config.value],
      description: isEmpty ? widget.config.description : widget.config.title,
      accent: 240,
      isFloating: !isEmpty,
      onTap: () => showModalBottomSheet(
        enableDrag: true,
        context: context,
        isDismissible: true,
        barrierColor: Color(0x553D3D66),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xFFF6F6FC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(color: Color(0x301e1e33), blurRadius: 35),
              ],
            ),
            padding: EdgeInsets.fromLTRB(
                25, 0, 25, MediaQuery.of(context).viewInsets.bottom + 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30,
                  child: Center(
                      child: Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: HSVColor.fromAHSV(.5, 240, 0.05, 0.9).toColor(),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  )),
                ),
                widget.config.input(processData),
              ],
            ),
          );
        },
      ),
    );
  }
}
