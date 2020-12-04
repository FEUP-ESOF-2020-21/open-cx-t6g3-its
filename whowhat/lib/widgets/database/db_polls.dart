import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whowhat/pages/upload_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addPoll(String name, String description, File image) async {
  CollectionReference databaseReference =
      FirebaseFirestore.instance.collection('polls');

  String uid = FirebaseAuth.instance.currentUser.uid.toString();

  String pollID = uid + DateTime.now().hashCode.toString();

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

Future<void> saveImage(
    File _image, CollectionReference ref, String pollID) async {
  ref.doc(pollID).set({});
}
