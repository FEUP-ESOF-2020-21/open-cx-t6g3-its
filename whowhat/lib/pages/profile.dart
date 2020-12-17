import 'dart:ffi';
import 'dart:io';
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

  File _imageFile;
  String _imageUrl;

  Future<Void> _uploadImage() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 500,
      imageQuality: 50,
    );

    File selected = File(pickedFile.path);

    selected = await cropImage(selected);
    _imageUrl = await uploadProfile(selected, uid);
  }

  void getImage() {
    var ref = FirebaseStorage.instance.ref().child('profileImages/' + uid);
    if (_imageFile == null) {
      ref.getDownloadURL().then((loc) => setState(() => _imageUrl = loc));
    }
  }

  @override
  Widget build(BuildContext context) {
    getImage();
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
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.5,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
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
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              'Job',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 30,
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
          ],
        ),
      ),
    );
  }
}
