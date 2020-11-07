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
          return Text("Loading");
        }

        return new Center(
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
                TextSpan(
                    text: ' ' + snapshot.data.docs.length.toString(),
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
