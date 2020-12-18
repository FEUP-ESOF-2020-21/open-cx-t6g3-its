import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whowhat/pages/create_question.dart';
import 'package:whowhat/pages/edit_question.dart';
import 'package:whowhat/widgets/database/db_polls.dart';

class ListQuestions extends StatefulWidget {
  final String id;

  ListQuestions({Key key, this.id}) : super(key: key);

  @override
  _MyListQuestions createState() => _MyListQuestions(this.id);
}

class _MyListQuestions extends State<ListQuestions> {
  final String id;

  _MyListQuestions(this.id);

  @override
  Widget build(BuildContext context) {
    CollectionReference questionsReference = FirebaseFirestore.instance
        .collection('polls')
        .doc(this.id)
        .collection('questions');
    int x = 0;

    return StreamBuilder<QuerySnapshot>(
      stream: questionsReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        }

        final List<String> entries = <String>[];
        snapshot.data.docs.forEach((element) {
          entries.add(
            element.data()['title'].toString(),
          );
        });

        return Scaffold(
          appBar: AppBar(
              title: Text("Create WHoWhat"),
              backgroundColor: Colors.blue[800],
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => Navigator.pop(context, false),
              )),
          backgroundColor: Colors.white,
          body: Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 1000.0,
                  child: new ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: entries.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return GestureDetector(
                          onHorizontalDragUpdate: (details) => {x},
                          child: InkWell(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                color: Colors.grey[200],
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Text(
                                      (index + 1).toString() +
                                          '. ' +
                                          entries[index],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                /**/
                                print(id);
                                print(index + 1);
                                Map<String, dynamic> info =
                                    await getQuestionByPollId(id, index + 1);
                                print(info['options']['1']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditQuestion(
                                          id: this.id,
                                          info: info,
                                          index: index + 1),
                                    ));
                                ;
                              }));
                    },
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          floatingActionButton: InkWell(
            child: Container(
              height: 70,
              width: 70,
              child: Icon(Icons.add_outlined, size: 35, color: Colors.white),
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
                    builder: (context) => CreateQuestion(id: this.id)),
              );
            },
          ),
        );
      },
    );
  }
}
