import 'package:flutter/material.dart';
import 'package:whowhat/widgets/PollCreateCard.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/widgets/GradientButton.dart';

class MyCreatePoll extends StatefulWidget {
  MyCreatePoll({Key key}) : super(key: key);

  @override
  _MyCreatePollState createState() => _MyCreatePollState();
}

class _MyCreatePollState extends State<MyCreatePoll> {
  int nPolls = 1;
  List<Widget> list = [PollCreateCard(number: 1)];

  _MyCreatePollState();

  void _addPoll() {
    nPolls++;
    list.add(PollCreateCard(number: nPolls));
  }

  void _removePoll() {
    if (nPolls > 1) {
      nPolls--;
      list.removeLast();
    }
  }

  void _send() {
    for (Widget widget in list) {
      print(widget.toString());
    }
  }

  List<Widget> _getPolls() {
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Create WHoWhat"),
          backgroundColor: Colors.blue[800],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pop(context, false),
          )),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.05),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            color: Colors.grey[400],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          child: (Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '  Name: ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22),
                              ))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextBox(
                          textInputType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '  Description: ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextBox(
                          textInputType: TextInputType.text,
                          obscureText: false,
                          size: 5,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        blurRadius: 25.0, // soften the shadow
                        spreadRadius: 0.2, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getPolls(),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: 10, left: MediaQuery.of(context).size.width * 0.1),
                child: Row(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: GradientButton(
                      text: 'Add',
                      onPressed: () {
                        setState(() {
                          _addPoll();
                        });
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: GradientButton(
                      text: 'Remove',
                      onPressed: () {
                        setState(() {
                          _removePoll();
                        });
                      },
                    ),
                  ),
                ])),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: GradientButton(
                  text: 'Create WHoWhat',
                  onPressed: () {
                    _send();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
