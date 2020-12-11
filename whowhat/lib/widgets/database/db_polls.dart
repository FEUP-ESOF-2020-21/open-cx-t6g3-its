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

  int questionId = await getNumberQuestions(pollId) + 1;

  await databaseReference.doc(questionId.toString()).set({
    "title": question,
  });

  for (String option in options) {
    await databaseReference
        .doc(questionId.toString())
        .collection('options')
        .doc()
        .set({"text": option});
  }
  await updateNumberQuestions(pollId);
}

Future<void> updateNumberQuestions(String id) async {
  DocumentReference pollReference =
      FirebaseFirestore.instance.collection('polls').doc(id);

  int nr_questions = await getNumberQuestions(id) + 1;

  await pollReference.update({"nr_questions": nr_questions}).then(
      (value) => print("Status updated!"));
}

Future<int> getNumberQuestions(String id) async {
  DocumentReference pollReference =
      FirebaseFirestore.instance.collection('polls').doc(id);

  DocumentSnapshot ds = await pollReference.get();

  return ds.data()["nr_questions"];
}
