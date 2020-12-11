import 'package:flutter/material.dart';
import 'package:whowhat/pages/session_loop.dart';
import 'package:whowhat/widgets/database/create_session.dart';
import 'package:whowhat/widgets/database/session_connection.dart';

class MyConnection extends StatefulWidget {
  String session;
  String pollName;
  bool admin = false;

  MyConnection({Key key, this.pollName, this.session, this.admin})
      : super(key: key);

  @override
  _MyConnectionState createState() =>
      _MyConnectionState(this.pollName, this.session, this.admin);
}

class _MyConnectionState extends State<MyConnection> {
  final String session;
  final bool admin;
  final String pollName;

  _MyConnectionState(this.pollName, this.session, this.admin);

  @override
  Widget build(BuildContext context) {
    if (this.admin) {
      return adminScaffold(context, session, this.pollName);
    } else {
      return userScaffold(context, session, this.pollName);
    }
  }
}

Scaffold userScaffold(BuildContext context, String session, String pollName) {
  return Scaffold(
    //resizeToAvoidBottomPadding: false,
    body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient:
            LinearGradient(colors: [Color(0xFF3186E3), Color(0xFF1D36C4)]),
      ),
      child: Center(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: UserSessionInformation(session: session),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(children: <Widget>[
                    Text('Waiting to start...',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    Image(image: AssetImage('assets/images/waiting.gif')),
                  ])),
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: <Widget>[
                      Text(
                        pollName != null ? pollName : 'Poll name here',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
            ]),
      ),
    ),
  );
}

Scaffold adminScaffold(BuildContext context, String session, String pollName) {
  //print(session);
  return Scaffold(
    //resizeToAvoidBottomPadding: false,
    body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient:
            LinearGradient(colors: [Color(0xFF3186E3), Color(0xFF1D36C4)]),
      ),
      child: Center(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: UserSessionInformation(session: session),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text('Share this code:',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: Container(
                    height: 100.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: new BoxDecoration(
                      color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: new BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        session == null ? '------' : session,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            letterSpacing: 20.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Column(
                    children: <Widget>[
                      Text(
                        pollName != null ? pollName : 'Poll name here',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 62,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.black, //Color(0xFF265DD3),
                          size: 50,
                        ),
                      ),
                    ),
                    onTap: () async {
                      increaseStatus(context, session);
                    }),
              ),
            ]),
      ),
    ),
  );
}
