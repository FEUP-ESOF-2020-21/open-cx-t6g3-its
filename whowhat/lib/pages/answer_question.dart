import 'package:flutter/material.dart';
import 'package:whowhat/widgets/database/db_polls.dart';

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

  return InkWell(
    child: Center(
      child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.02,
              bottom: MediaQuery.of(context).size.width * 0.02),
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
          ])),
    ),
    onTap: () {},
  );
}

class AnswerQuestion extends StatefulWidget {
  final Map<String, dynamic> info;
  final String session;

  AnswerQuestion({Key key, this.info, this.session}) : super(key: key);

  @override
  _MyAnswerQuestion createState() => _MyAnswerQuestion(this.info, this.session);
}

class _MyAnswerQuestion extends State<AnswerQuestion> {
  final Map<String, dynamic> info;
  final String session;

  _MyAnswerQuestion(this.info, this.session);

  List<Widget> _getOption() {
    List<Widget> list = new List();

    info['options'].entries.forEach(
        (element) => list.add(Option(context, element.key, element.value)));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          FutureBuilder(
              future: getImagePath(session),
              builder: (context, snapshot) {
                return Container(
                    width: screenWidth,
                    height: screenHeight * 0.30,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(snapshot.data),
                            fit: BoxFit.cover)));
              }),
          Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              alignment: Alignment.center,
              height: screenHeight * 0.8,
              width: screenWidth * 0.8,
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.04),
                  child: Text(info['title'],
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.clip,
                      softWrap: true),
                ),
                Column(
                  children: _getOption(),
                )
              ])),
        ]))));
  }
}
