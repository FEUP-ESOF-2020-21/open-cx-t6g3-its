import 'package:flutter/material.dart';
import 'package:whowhat/widgets/TextPanel.dart';

Widget Option(context, id, text) {
  Color color;

  switch (id) {
    case "1":
      color = Colors.red;
      break;
    case "2":
      color = Colors.blue;
      break;
    case "3":
      color = Colors.green;
      break;
    case "4":
      color = Colors.orange;
  }

  return Padding(
      padding: EdgeInsets.all(10),
      child: Row(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width * 0.05,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15))),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.10,
            width: MediaQuery.of(context).size.width * 0.70,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                      ),
                    )))),
      ]));
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

    info['options'].entries.forEach(
        (element) => list.add(Option(context, element.key, element.value)));

    print(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/whowhat-786d8.appspot.com/o/pollImages%2Fdefault.jpg?alt=media&token=c040ec37-4516-4172-93ef-2ed09842c82e'),
                      fit: BoxFit.cover))),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.10),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.05),
                  child: Text(
                    info['title'],
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: _getOption(),
                )
              ])),
        ]))));
  }
}
