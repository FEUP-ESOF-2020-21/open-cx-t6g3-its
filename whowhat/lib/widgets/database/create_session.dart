import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whowhat/pages/connection.dart';

String generateRandomSession() {
  var rng;
  String newSession = "";

  for (var i = 0; i < 6; i++) {
    rng = new Random();
    newSession += rng.nextInt(9).toString();
  }

  return newSession;
}

Future<String> createSession(BuildContext context) async {
  CollectionReference databaseReference =
      FirebaseFirestore.instance.collection('sessions');

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
          .collection('users')
          .doc('speaker')
          .set({});
    }
  }

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyConnection(
                session: newSession,
                admin: true,
              )));
  return newSession;
}
