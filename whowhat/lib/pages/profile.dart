import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whowhat/pages/upload_image.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String uid = FirebaseAuth.instance.currentUser.uid.toString();

  String _imageUrl;
  String _tmpUrl;

  Future<Void> _uploadImage() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 500,
      imageQuality: 50,
    );

    File selected = File(pickedFile.path);

    selected = await cropImage(selected);
    _tmpUrl = await uploadProfile(selected, uid);
    setState(() {
      _imageUrl = _tmpUrl;
    });
  }

  initState() {
    getImage();
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> getImage() async {
    var ref = FirebaseStorage.instance.ref().child('profileImages/' + uid);
    _tmpUrl = await ref.getDownloadURL();
    setState(() {
      _imageUrl = _tmpUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference usersReference =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: usersReference.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("");
          }
          Map<String, dynamic> profileData = snapshot.data.data();
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return Scaffold(
            appBar: AppBar(
                title: Text("WHoWhat Profile"),
                backgroundColor: Colors.blue[800],
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () => Navigator.pop(context, false),
                )),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.05,
                        bottom: height * 0.08,
                        left: width * 0.1,
                        right: width * 0.1),
                    child: Container(
                      width: width * 0.8,
                      height: height * 0.65,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.05),
                          child: Center(
                            child: Container(
                              width: width * 0.8,
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                        height: width * 0.5,
                                        width: width * 0.5,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: _imageUrl != null
                                                  ? NetworkImage(_imageUrl)
                                                  : NetworkImage(
                                                      'https://firebasestorage.googleapis.com/v0/b/whowhat-786d8.appspot.com/o/pollImages%2Fdefault.jpg?alt=media&token=c040ec37-4516-4172-93ef-2ed09842c82e'),
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.grey[400],
                                            shape: BoxShape.circle)),
                                    onTap: () {
                                      _uploadImage();
                                    },
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[500],
                                    blurRadius: 25.0, // soften the shadow
                                    spreadRadius: 0.2, //extend the shadow
                                    offset: Offset(
                                      5.0, // Move to right 10  horizontally
                                      5.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.05, bottom: height * 0.010),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.025),
                                  child: Text(
                                    profileData['name'],
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.02),
                                  child: Text(
                                    profileData['job'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.02),
                                  child: Text(
                                    profileData['email'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                              ]),
                        ),
                      ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500],
                            blurRadius: 25.0, // soften the shadow
                            spreadRadius: 0.2, //extend the shadow
                            offset: Offset(
                              5.0, // Move to right 10  horizontally
                              5.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      height: height * 0.07,
                      width: width * 0.5,
                      child: Center(
                          child: Text(
                        "Log Out",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      )),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red[400]),
                    ),
                    onTap: () {
                      logout();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
