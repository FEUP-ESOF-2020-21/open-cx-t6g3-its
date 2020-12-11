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

  int counter = 1;
  for (String option in options) {
    if (option != "") {
      await databaseReference
          .doc(questionId.toString())
          .collection('options')
          .doc(counter.toString())
          .set({"text": option});
      counter++;
    }
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

Future<Map<String, dynamic>> getQuestion(String id, int nr_question) async {
  String pollId = await getPollId(id);

  CollectionReference questionsReference = FirebaseFirestore.instance
      .collection('polls')
      .doc(pollId)
      .collection('questions');

  DocumentSnapshot questionSnap =
      await questionsReference.doc(nr_question.toString()).get();

  String title = questionSnap.data()['title'];

  QuerySnapshot optionsSnap = await questionsReference
      .doc(nr_question.toString())
      .collection('options')
      .get();

  Map<String, String> options = new Map();

  optionsSnap.docs.forEach((element) {
    String text = element.data()["text"];
    if (text != "") options[element.id] = element.data()["text"];
  });

  Map<String, dynamic> question = {"title": title, "options": options};

  return question;
}

Future<String> getPollId(String sessionId) async {
  DocumentReference dr =
      FirebaseFirestore.instance.collection('sessions').doc(sessionId);

  print(sessionId);

  DocumentSnapshot ds = await dr.get();
  return ds.data()["poll"];
}
