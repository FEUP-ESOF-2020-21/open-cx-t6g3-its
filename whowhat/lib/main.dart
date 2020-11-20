import 'package:flutter/material.dart';
import 'package:whowhat/pages/create_poll.dart';
import 'package:whowhat/pages/loading.dart';
import 'package:whowhat/pages/login.dart';
import 'package:whowhat/pages/polls.dart';
import 'package:whowhat/pages/error.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whowhat/pages/signup.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyError(errorMsg: "Error"),
            debugShowCheckedModeBanner: false,
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          //  FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyLogin(),
            debugShowCheckedModeBanner: false,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyLoading(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

/**/
