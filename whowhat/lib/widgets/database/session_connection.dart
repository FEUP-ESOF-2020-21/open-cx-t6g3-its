import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserSessionInformation extends StatelessWidget {
  final String session;

  const UserSessionInformation({Key key, this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('sessions')
        .doc(this.session)
        .collection('users');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        }

        int nUsers = snapshot.data.docs.length;
        if (!(nUsers >= 0)) {
          nUsers = 0;
        }

        return new Center(
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
                TextSpan(
                    text: ' ' + nUsers.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Check If Document Exists
Future<bool> availableSession(String session) async {
  try {
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection('sessions');

    var doc = await collectionRef.doc(session).get();
    return doc.exists;
  } catch (e) {
    throw e;
  }
}

void joinSession(String session) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  // Get reference to Firestore collection
  var databaseReference = FirebaseFirestore.instance
      .collection('sessions')
      .doc(session)
      .collection('users');

  await databaseReference.doc(auth.currentUser.uid).set({});
}
