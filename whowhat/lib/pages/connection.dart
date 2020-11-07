import 'package:flutter/material.dart';
import 'package:whowhat/widgets/database/session_connection.dart';

//final Future<FirebaseApp> _initialization = Firebase.initializeApp();

class MyConnection extends StatefulWidget {
  String session;
  bool admin = false;

  MyConnection({Key key, this.session, this.admin}) : super(key: key);

  @override
  _MyConnectionState createState() =>
      _MyConnectionState(this.session, this.admin);
}

class _MyConnectionState extends State<MyConnection> {
  final String session;
  final bool admin;

  _MyConnectionState(this.session, this.admin);

  @override
  Widget build(BuildContext context) {
    if (this.admin) {
      return adminScaffold(context, session);
    } else {
      return userScaffold(context, session);
    }
  }
}

Scaffold userScaffold(BuildContext context, String session) {
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
                        'Quiz name here',
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

Scaffold adminScaffold(BuildContext context, String session) {
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
                    width: 300.0,
                    decoration: new BoxDecoration(
                      color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: new BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        session == null ? '------' : session,
                        style: TextStyle(
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
                        'Quiz name here',
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
