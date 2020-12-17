import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whowhat/pages/menu.dart';
import 'package:whowhat/widgets/GradientButton.dart';
import 'package:whowhat/widgets/TextPanel.dart';
import 'package:whowhat/widgets/database/db_polls.dart';

class MyPollDone extends StatefulWidget {
  final String id;
  MyPollDone({Key key, this.id}) : super(key: key);

  @override
  _MyPollDoneState createState() => _MyPollDoneState(this.id);
}

class _MyPollDoneState extends State<MyPollDone> {
  final String id;
  _MyPollDoneState(this.id);

  @override
  Widget build(BuildContext context) {
    return endingScaffold(context, id);
  }
}

Scaffold endingScaffold(BuildContext context, String id) {
  return Scaffold(
    //resizeToAvoidBottomPadding: false,
    body: SingleChildScrollView(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xFFEBF5FF),
      ),
      child: Column(children: <Widget>[
        Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: TextPanel(
              text: '   This Poll has ended!',
              height: 100,
              width: MediaQuery.of(context).size.width * 0.8,
            )),
        Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Text(
              'Thanks for Participating.',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            )),
        Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
            child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: GradientButton(
                    text: 'Return to Menu',
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyMenu()),
                      );
                    },
                  ),
                )))
      ]),
    )),
  );
}
