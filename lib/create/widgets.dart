import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasker/slikker.dart';

Map<String?, dynamic>? _toCreate;

Widget acceptButton(Function onTap) => SlikkerCard(
      onTap: onTap,
      child: SizedBox(
        height: 52,
        width: 52,
        child: Center(
          child: Text('👍', style: TextStyle(fontSize: 18)),
        ),
      ),
    );

class CreatePageTextField extends StatelessWidget {
  final Function callback;
  CreatePageTextField(this.callback);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          Expanded(
            child: SlikkerTextField(
              accent: 240,
              //controller: controller,
              hintText: 'Type something',
            ),
          ),
          Container(width: 20),
          acceptButton(() => callback('Hey'))
        ],
      ),
    );
  }
}

class CreatePageProps extends StatefulWidget {
  final String? title;
  final String? description;
  final String? value;
  final Function? input;
  final Function? callback;
  final Function? display;

  CreatePageProps({
    this.title,
    this.value,
    this.description,
    this.input,
    this.callback,
    this.display,
  });
  @override
  _CreatePagePropsState createState() => _CreatePagePropsState();
}

class _CreatePagePropsState extends State<CreatePageProps> {
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
              boxShadow: [BoxShadow(color: Color(0x301e1e33), blurRadius: 35)],
            ),
            padding: EdgeInsets.fromLTRB(
                25, 25, 25, 25 + MediaQuery.of(context).viewInsets.bottom),
            child: widget.input!((newData) {
              _toCreate![widget.value] = newData;
              setState(() => data = newData != null);
              widget.callback!();
              Navigator.pop(context);
            }),
          );
        },
      );

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
              : Text(
                  _toCreate![widget.value] ?? widget.title!,
                  style: TextStyle(
                    fontSize: 17,
                    color: data ? Color(0xFF6666FF) : Color(0xFF3D3D66),
                  ),
                ),
          Container(height: 8),
          Text(
            data ? widget.title! : widget.description!,
            style: TextStyle(
              fontSize: 15,
              color: data ? Color(0x4C6666FF) : Color(0x4C3D3D66),
            ),
          ),
        ],
      ),
      borderRadius: BorderRadius.circular(12),
      isFloating: data,
      padding: EdgeInsets.all(17),
      onTap: this.enterValue,
    );
  }
}
