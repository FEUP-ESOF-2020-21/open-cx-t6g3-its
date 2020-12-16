import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnswersNumber extends StatelessWidget {
  final String session;
  final String question;
  final String option;
  final String text;

  const AnswersNumber(
      {Key key, this.session, this.question, this.option, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DocumentReference questions = FirebaseFirestore.instance
        .collection('sessions')
        .doc(this.session)
        .collection('questions')
        .doc(this.question);

    CollectionReference answers = FirebaseFirestore.instance
        .collection('sessions')
        .doc(this.session)
        .collection('questions')
        .doc(this.question)
        .collection('options')
        .doc(this.option)
        .collection('answers');

    return StreamBuilder<QuerySnapshot>(
      stream: answers.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return StreamBuilder(
          stream: questions.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot2) {
            if (snapshot2.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot2.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            int totalAnswers = 1;
            double percentage = 0;
            int nAnswers = 0;
            if (snapshot.data != null) nAnswers = snapshot.data.docs.length;

            if (nAnswers != 0) {
              if (snapshot2.data != null)
                totalAnswers = snapshot2.data.get('totalAnswers');
            }

            percentage = nAnswers / totalAnswers;
            return Option(context, option, text, percentage);
          },
        );
      },
    );
  }

  Widget Option(context, id, text, percentage) {
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
    return Center(
      child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.015,
              bottom: MediaQuery.of(context).size.width * 0.015),
          child: Stack(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * percentage,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.08),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                        ),
                      ))),
            )
          ])),
    );
  }
}
