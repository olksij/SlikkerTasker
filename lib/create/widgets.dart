import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasker/info_card.dart';
import 'package:tasker/slikker.dart';

Map<String?, dynamic> _toCreate = {};

// --- ACCEPT BUTTON --- ///

class CreatePageAcceptButton extends StatelessWidget {
  final Function onTap;

  CreatePageAcceptButton(this.onTap);

  @override
  Widget build(BuildContext context) {
    return SlikkerCard(
      onTap: onTap,
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

class CreatePageTextField extends StatelessWidget {
  final Function callback;
  CreatePageTextField(this.callback);

  final TextEditingController controller = TextEditingController();
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
          CreatePageAcceptButton(() => callback(controller.value.text))
        ],
      ),
    );
  }
}

// --- PROPS WIDGET --- ///

class CreatePageProps extends StatefulWidget {
  final String title;
  final String description;
  final String value;
  final Function input;

  CreatePageProps({
    required this.title,
    required this.value,
    required this.description,
    required this.input,
  });

  @override
  _CreatePagePropsState createState() => _CreatePagePropsState();
}

class _CreatePagePropsState extends State<CreatePageProps> {
  late bool isEmpty;

  @override
  void initState() {
    super.initState();
    isEmpty = _toCreate[widget.value] == null;
  }

  processData(newData) {
    _toCreate[widget.value] = newData;
    setState(() {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      data: {
        'title': isEmpty ? widget.title : "h",
        'description': isEmpty ? widget.description : widget.title
      },
      accent: 240,
      isFloating: !isEmpty,
      showButton: false,
      onCardTap: () => showModalBottomSheet(
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
            padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
            child: widget.input(processData),
          );
        },
      ),
    );
  }
}
