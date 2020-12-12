import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whowhat/pages/answer_question.dart';
import 'package:whowhat/pages/connection.dart';
import 'package:whowhat/widgets/database/db_polls.dart';

class SessionLoop extends StatefulWidget {
  final String id;

  SessionLoop({Key key, this.id}) : super(key: key);

  @override
  _SessionLoopState createState() => _SessionLoopState(this.id);
}

class _SessionLoopState extends State<SessionLoop> {
  final String id;

  _SessionLoopState(this.id);

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
          return Text("Loading");
        }

        bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

        if (snapshot.data["speaker"] == auth.currentUser.uid) {
          switch (snapshot.data["status"]) {
            case 0:
              return adminScaffold(context, id, 'Poll');
              break;
            case -1:
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
                      return Text("Loading");
                    }

                    return AnswerQuestion(info: snapshot.data, session: id);
                  });

              break;
          }
        } else {
          switch (snapshot.data["status"]) {
            case 0:
              return userScaffold(context, id, 'Poll');
              break;
            case -1:
              break;
            default:
              return Scaffold(body: Center(child: Text("USER")));
              break;
          }
        }
      },
    );
  }
}
