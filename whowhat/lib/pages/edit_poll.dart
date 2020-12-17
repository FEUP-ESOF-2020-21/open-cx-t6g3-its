import 'dart:ffi';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whowhat/pages/upload_image.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/widgets/GradientButton.dart';

class MyEditPoll extends StatefulWidget {
  final Map<String, dynamic> info;
  MyEditPoll({Key key, this.info}) : super(key: key);

  @override
  _MyEditPollState createState() => _MyEditPollState(this.info);
}

class _MyEditPollState extends State<MyEditPoll> {
  final Map<String, dynamic> info;
  _MyEditPollState(this.info);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  File _imageFile;

  Future<Void> _uploadImage() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 500,
      imageQuality: 50,
    );

    File selected = File(pickedFile.path);

    selected = await cropImage(selected);
    setState(() {
      _imageFile = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = this.info['title'];
    descriptionController.text = this.info['description'];

    return Scaffold(
      appBar: AppBar(
          title: Text("Edit WHoWhat"),
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
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.05),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                            height: MediaQuery.of(context).size.width * 0.8,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: _imageFile != null
                                    ? FileImage(_imageFile)
                                    : NetworkImage(this.info['image']),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              color: Colors.grey[400],
                            )),
                        onTap: () {
                          _uploadImage();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          child: (Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '  Name: ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextBox(
                          textInputType: TextInputType.text,
                          controller: titleController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '  Description: ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextBox(
                          controller: descriptionController,
                          textInputType: TextInputType.text,
                          obscureText: false,
                          size: 5,
                        ),
                      ),
                    ],
                  ),
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
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: GradientButton(
                  text: 'Create and continue',
                  onPressed: () async {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}