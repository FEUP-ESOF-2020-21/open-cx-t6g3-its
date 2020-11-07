import 'package:flutter/material.dart';
import 'package:whowhat/widgets/database/session_connection.dart';

//final Future<FirebaseApp> _initialization = Firebase.initializeApp();

class MyConnection extends StatefulWidget {
  final String session;

  const MyConnection({Key key, this.session}) : super(key: key);

  @override
  _MyConnectionState createState() => _MyConnectionState(this.session);
}

class _MyConnectionState extends State<MyConnection> {
  final String session;

  _MyConnectionState(this.session);

  @override
  Widget build(BuildContext context) {
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
                  child: UserSessionInformation(session: this.session),
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
}
