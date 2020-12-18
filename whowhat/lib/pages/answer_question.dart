import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whowhat/widgets/GradientButton.dart';
import 'package:whowhat/widgets/database/answers_stats.dart';
import 'package:whowhat/widgets/database/create_session.dart';
import 'package:whowhat/widgets/database/db_polls.dart';

class AnswerQuestion extends StatefulWidget {
  final Map<String, dynamic> info;
  final String session;
  final bool speaker;

  AnswerQuestion({Key key, this.info, this.session, this.speaker})
      : super(key: key);

  @override
  _MyAnswerQuestion createState() =>
      _MyAnswerQuestion(this.info, this.session, this.speaker);
}

class _MyAnswerQuestion extends State<AnswerQuestion> {
  final Map<String, dynamic> info;
  final String session;
  final bool speaker;
  bool answered = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  _MyAnswerQuestion(this.info, this.session, this.speaker);

  List<Widget> _getOption() {
    List<Widget> list = [];

    info['options'].entries.forEach(
        (element) => list.add(Option(context, element.key, element.value)));

    return list;
  }

  List<Widget> _getStats() {
    List<Widget> list = [];

    info['options'].entries.forEach((element) => list.add(AnswersNumber(
        session: session,
        question: info["nr_question"].toString(),
        option: element.key,
        text: element.value)));

    return list;
  }

  List<Widget> _getStatsSpeaker() {
    List<Widget> list = [];

    info['options'].entries.forEach((element) => list.add(AnswersNumber(
        session: session,
        question: info["nr_question"].toString(),
        option: element.key,
        text: element.value)));

    list.add(
      GradientButton(
        text: 'Next Question',
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.06,
            bottom: MediaQuery.of(context).size.width * 0.02),
        onPressed: () {
          increaseStatus(context, session);
        },
      ),
    );

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
                            image: snapshot.data != null
                                ? NetworkImage(snapshot.data)
                                : NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/whowhat-786d8.appspot.com/o/pollImages%2Fdefault.jpg?alt=media&token=c040ec37-4516-4172-93ef-2ed09842c82e'),
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
                if (speaker)
                  Column(children: _getStatsSpeaker())
                else
                  answered == false
                      ? Column(
                          children: _getOption(),
                        )
                      : Column(
                          children: _getStats(),
                        )
              ])),
        ]))));
  }

  Future<void> chooseAnswer(option) async {
    setState(() {
      answered = true;
    });
    String question = info["nr_question"].toString();
    String uid = auth.currentUser.uid;
    DocumentReference questionReference = FirebaseFirestore.instance
        .collection('sessions')
        .doc(session)
        .collection('questions')
        .doc(question);
    await questionReference
        .collection('options')
        .doc(option)
        .collection('answers')
        .doc()
        .set({"uid": uid});
    await questionReference.set(
        {"totalAnswers": FieldValue.increment(1)}, SetOptions(merge: true));
  }

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
      onTap: () {
        chooseAnswer(id);
      },
    );
  }
}
