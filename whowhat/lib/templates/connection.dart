import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyConnection extends StatefulWidget {
  @override
  _MyConnectionState createState() => _MyConnectionState();
}

class _MyConnectionState extends State<MyConnection> {
  int _connectedUsers = 0;

  void _increaseUsers() {
    setState(() {
      _connectedUsers += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    store.collection('/users').get();

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
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.person,
                                size: 30, color: Colors.white),
                          ),
                          TextSpan(
                              text: " $_connectedUsers",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Roboto',
                              )),
                        ],
                      ),
                    ),
                  ),
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
      floatingActionButton: InkWell(
        child: Container(
          height: 40,
          width: 40,
          child: Icon(Icons.add, size: 40, color: Colors.blue[800]),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        onTap: _increaseUsers,
      ),
    );
  }
}
