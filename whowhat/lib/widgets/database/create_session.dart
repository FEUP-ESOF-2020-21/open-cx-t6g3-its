import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

String generateRandomSession() {
  var rng;
  String new_session = "";

  for (var i = 0; i < 6; i++) {
    rng = new Random();
    new_session += rng.nextInt(9).toString();
  }

  return new_session;
}

void createSession() async {
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
}
