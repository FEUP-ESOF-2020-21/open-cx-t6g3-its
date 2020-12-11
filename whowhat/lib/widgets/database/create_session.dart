import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whowhat/pages/connection.dart';
import 'package:whowhat/pages/session_loop.dart';

String generateRandomSession() {
  var rng;
  String newSession = "";

  for (var i = 0; i < 6; i++) {
    rng = new Random();
    newSession += rng.nextInt(9).toString();
  }

  return newSession;
}

Future<void> createSession(BuildContext context, String pollName) async {
  CollectionReference databaseReference =
      FirebaseFirestore.instance.collection('sessions');

  FirebaseAuth auth = FirebaseAuth.instance;

  String newSession = generateRandomSession();

  bool exists = true;

  while (exists) {
    DocumentSnapshot ds = await databaseReference.doc(newSession).get();
    exists = ds.exists;

    if (exists) {
      newSession = generateRandomSession();
    } else {
      await databaseReference.doc(newSession).set({});
      await databaseReference
          .doc(newSession)
          .set({"speaker": auth.currentUser.uid, "status": 0});
    }
  }

  Navigator.push(context,
      MaterialPageRoute(builder: (context) => SessionLoop(id: newSession)));
}
