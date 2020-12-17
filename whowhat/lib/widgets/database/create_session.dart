import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:flutter/material.dart';
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

Future<void> createSession(BuildContext context, String pollID,
    String pollTitle, int nrQuestions) async {
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
      await databaseReference.doc(newSession).set({
        "poll": pollID,
        "speaker": auth.currentUser.uid,
        "status": 0,
        "nrQuestions": nrQuestions
      });
    }
  }

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SessionLoop(id: newSession, title: pollTitle)));
}

Future<void> increaseStatus(BuildContext context, String id) async {
  DocumentReference databaseReference =
      FirebaseFirestore.instance.collection('sessions').doc(id);

  DocumentSnapshot ds = await databaseReference.get();
  int status = ds.data()["status"];
  int newStatus = 0;
  int tmpStatus = status + 1;
  int maxQuestions = await ds.data()["nrQuestions"];
  if (tmpStatus > maxQuestions) {
    tmpStatus = -1;
  }
  newStatus = tmpStatus;

  prepareNextQuestion(tmpStatus, id);

  await databaseReference
      .update({"status": newStatus}).then((value) => print("Status updated!"));
}

Future<void> prepareNextQuestion(tmpStatus, sessionId) async {
  CollectionReference databaseReference = FirebaseFirestore.instance
      .collection('sessions')
      .doc(sessionId.toString())
      .collection('questions');

  await databaseReference.doc(tmpStatus.toString()).set({"totalAnswers": 0});
}
