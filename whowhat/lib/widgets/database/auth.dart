import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference databaseReference =
      FirebaseFirestore.instance.collection('users');

  //Sign in Anon

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return (user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmail(
      String email, String password, String name, String job) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      String uid = user.uid.toString();

      await databaseReference.doc(uid).set({'name': name, 'job': job});

      return (user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> getUserName() async {
    if (_auth.currentUser != null) {
      DocumentSnapshot ds =
          await databaseReference.doc(_auth.currentUser.uid).get();
      return ds.data()['name'];
    }

    return "nada";
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
