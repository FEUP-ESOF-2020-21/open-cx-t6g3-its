import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whowhat/pages/upload_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addPoll(
    String pollID, String name, String description, File image) async {
  CollectionReference databaseReference =
      FirebaseFirestore.instance.collection('polls');

  String uid = FirebaseAuth.instance.currentUser.uid.toString();

  String imageURL;
  if (image != null) {
    imageURL = await uploadFile(image, pollID);
  } else {
    imageURL =
        'https://firebasestorage.googleapis.com/v0/b/whowhat-786d8.appspot.com/o/pollImages%2Fdefault.jpg?alt=media&token=c040ec37-4516-4172-93ef-2ed09842c82e';
  }

  await databaseReference.doc(pollID).set({
    "uid": uid,
    "title": name,
    "description": description,
    "image": imageURL,
    "nr_questions": 0,
  });
}

Future<void> addQuestion(
    String pollId, String question, List<String> options) async {
  CollectionReference databaseReference = FirebaseFirestore.instance
      .collection('polls')
      .doc(pollId)
      .collection('questions');

  String code = question.hashCode.toString() +
      pollId.hashCode.toString() +
      DateTime.now().hashCode.toString();

  await databaseReference.doc(code).set({
    "title": question,
  });

  for (String option in options) {
    await databaseReference
        .doc(code)
        .collection('options')
        .doc()
        .set({"text": option});
  }

/*
  CollectionReference nrquestions =
      FirebaseFirestore.instance.collection('polls');

  await nrquestions
      .doc(pollId)
      .set({"nr_questions": databaseReference.get().then((value) => null)});*/
}
