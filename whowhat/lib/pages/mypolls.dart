import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whowhat/widgets/PollCard.dart';
import 'package:whowhat/pages/create_poll.dart';
import 'package:whowhat/widgets/database/create_session.dart';

class MyPolls extends StatelessWidget {
  const MyPolls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference pollsReference =
        FirebaseFirestore.instance.collection('polls');

    return StreamBuilder<QuerySnapshot>(
      stream: pollsReference
          .where('uid', isEqualTo: auth.currentUser.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

        if (auth.currentUser != null) {
          print(auth.currentUser.uid);
        }

        List<Widget> polls = [];
        snapshot.data.docs.forEach((element) {
          polls.add(PollCard(
              title: element.data()['title'].toString(),
              description:
                  element.data()['nr_questions'].toString() + ' questions',
              imageURL: element.data()['image'].toString(),
              onTap: () {
                createSession(context, element.id.toString(),
                    element.data()['title'].toString());
              }));
        });

        return Scaffold(
          appBar: AppBar(
            title: Text('My WHoWhats'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context, false),
            ),
            backgroundColor: Colors.blue[800],
          ),
          //resizeToAvoidBottomPadding: false,
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: polls,
                ),
              ),
            ),
          ),

          floatingActionButton: keyboardIsOpened
              ? null
              : InkWell(
                  child: Container(
                    height: 70,
                    width: 70,
                    child:
                        Icon(Icons.add_outlined, size: 35, color: Colors.white),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [Color(0xFF3186E3), Color(0xFF1D36C4)]),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyCreatePoll(),
                        ));
                  },
                ),
        );
      },
    );
  }
}

/*
Future<List> getPollsByUser(BuildContext context) async {
  CollectionReference databaseReference =
      FirebaseFirestore.instance.collection('polls');

  
}*/
