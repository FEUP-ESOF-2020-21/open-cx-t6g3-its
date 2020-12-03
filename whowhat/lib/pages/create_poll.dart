import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whowhat/pages/upload_image.dart';
import 'package:whowhat/widgets/PollCreateCard.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/widgets/GradientButton.dart';

class MyCreatePoll extends StatefulWidget {
  MyCreatePoll({Key key}) : super(key: key);

  @override
  _MyCreatePollState createState() => _MyCreatePollState();
}

class _MyCreatePollState extends State<MyCreatePoll> {
  String pollID = FirebaseAuth.instance.currentUser.uid.toString() +
      DateTime.now().hashCode.toString();

  int nPolls = 1;
  List<Widget> list = [PollCreateCard(number: 1)];
  bool hasImage = false;

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

  _MyCreatePollState();

  void _addPoll() {
    nPolls++;
    list.add(PollCreateCard(number: nPolls));
  }

  void _removePoll() {
    if (nPolls > 1) {
      nPolls--;
      list.removeLast();
    }
  }

  void _send() {
    for (Widget widget in list) {
      print(widget.toString());
    }
  }

  List<Widget> _getPolls() {
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Create WHoWhat"),
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
                                    : NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/whowhat-786d8.appspot.com/o/pollImages%2Fdefault.jpg?alt=media&token=c040ec37-4516-4172-93ef-2ed09842c82e'),
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
                                    fontSize: 22),
                              ))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextBox(
                          textInputType: TextInputType.text,
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
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getPolls(),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: 10, left: MediaQuery.of(context).size.width * 0.1),
                child: Row(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: GradientButton(
                      text: 'Add',
                      onPressed: () {
                        setState(() {
                          _addPoll();
                        });
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: GradientButton(
                      text: 'Remove',
                      onPressed: () {
                        setState(() {
                          _removePoll();
                        });
                      },
                    ),
                  ),
                ])),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: GradientButton(
                  text: 'Create WHoWhat',
                  onPressed: () {
                    _send();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
