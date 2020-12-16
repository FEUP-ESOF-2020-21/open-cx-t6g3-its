import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whowhat/pages/answer_question.dart';
import 'package:whowhat/pages/connection.dart';
import 'package:whowhat/pages/pollDone.dart';
import 'package:whowhat/widgets/database/db_polls.dart';

import 'loading.dart';

class SessionLoop extends StatefulWidget {
  final String id;
  final String title;

  SessionLoop({Key key, this.id, this.title}) : super(key: key);

  @override
  _SessionLoopState createState() => _SessionLoopState(this.id, this.title);
}

class _SessionLoopState extends State<SessionLoop> {
  final String id;
  final String title;

  _SessionLoopState(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    DocumentReference questionsReference =
        FirebaseFirestore.instance.collection('sessions').doc(id);

    return StreamBuilder<DocumentSnapshot>(
      stream: questionsReference.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return MyLoading();
        }

        if (snapshot.data["speaker"] == auth.currentUser.uid) {
          switch (snapshot.data["status"]) {
            case 0:
              return adminScaffold(context, id, title);
              break;
            case -1:
              return MyPollDone();

              break;
            default:
              return FutureBuilder(
                  future: getQuestion(id, snapshot.data["status"]),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return MyLoading();
                    }

                    return AnswerQuestion(
                        info: snapshot.data, session: id, speaker: true);
                  });

              break;
          }
        } else {
          switch (snapshot.data["status"]) {
            case 0:
              return userScaffold(context, id, title);
              break;
            case -1:
              return MyPollDone();
              break;
            default:
              return FutureBuilder(
                  future: getQuestion(id, snapshot.data["status"]),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return MyLoading();
                    }

                    return AnswerQuestion(
                        info: snapshot.data, session: id, speaker: false);
                  });
              break;
          }
        }
      },
    );
  }
}
