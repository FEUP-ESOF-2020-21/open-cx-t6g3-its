import 'package:flutter/material.dart';
import 'package:whowhat/widgets/database/session_connection.dart';

//final Future<FirebaseApp> _initialization = Firebase.initializeApp();

class MyError extends StatefulWidget {
  String errorMsg;

  MyError({Key key, this.errorMsg}) : super(key: key);

  @override
  _MyErrorState createState() => _MyErrorState(this.errorMsg);
}

class _MyErrorState extends State<MyError> {
  final String errorMsg;

  _MyErrorState(this.errorMsg);

  @override
  Widget build(BuildContext context) {
    return errorScaffold(context, errorMsg);
  }
}

Scaffold errorScaffold(BuildContext context, String errorMsg) {
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
                  padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height / 2) - 100),
                  child: Column(children: <Widget>[
                    Text('An error has ocurred...',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ])),
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: <Widget>[
                      Text(
                        errorMsg,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ]),
      ),
    ),
  );
}
