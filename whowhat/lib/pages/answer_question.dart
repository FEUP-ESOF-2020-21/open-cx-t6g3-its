import 'package:flutter/material.dart';
import 'package:whowhat/widgets/TextPanel.dart';

Widget Option(id, text) {
  return Padding(
      padding: EdgeInsets.all(10),
      child: TextPanel(
        text: text,
        height: 100,
        width: 200,
      ));
}

class AnswerQuestion extends StatefulWidget {
  final Map<String, dynamic> info;

  AnswerQuestion({Key key, this.info}) : super(key: key);

  @override
  _MyAnswerQuestion createState() => _MyAnswerQuestion(this.info);
}

class _MyAnswerQuestion extends State<AnswerQuestion> {
  final Map<String, dynamic> info;

  _MyAnswerQuestion(this.info);

  List<Widget> _getOption() {
    List<Widget> list = new List();

    info['options']
        .entries
        .forEach((element) => list.add(Option(element.key, element.value)));

    print(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(children: <Widget>[
        Text(info['title']),
        Column(
          children: _getOption(),
        )
      ])),
    );
  }
}
