import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyImageUpload extends StatefulWidget {
  final String pollID;

  MyImageUpload({Key key, this.pollID}) : super(key: key);

  @override
  _MyImageUploadState createState() => _MyImageUploadState(this.pollID);
}

class _MyImageUploadState extends State<MyImageUpload> {
  File _imageFile;
  bool _fileUploaded = false;
  final pollID;
  CollectionReference databaseReference =
      FirebaseFirestore.instance.collection('pollImages');

  _MyImageUploadState(this.pollID);

  Future<void> _pickImage(ImageSource source) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: source,
      maxHeight: 500,
      imageQuality: 50,
    );
    final File selected = File(pickedFile.path);
    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> saveImage(
      File _image, CollectionReference ref, String pollID) async {
    String imageURL = await uploadFile(_image, pollID);
    ref.doc(pollID).set({"images": imageURL});
  }

  Future<String> uploadFile(File _image, String pollID) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('pollImages/$pollID');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    setState(() {
      _fileUploaded = true;
    });
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  Future<void> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        maxWidth: 500,
        maxHeight: 500,
        compressQuality: 50,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.blue[800],
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          resetAspectRatioEnabled: false,
          aspectRatioLockEnabled: true,
        ));

    setState(() {
      _imageFile = croppedFile ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
      _fileUploaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Image"),
          backgroundColor: Colors.blue[800],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (_imageFile != null) ...[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: MediaQuery.of(context).size.width * 0.8,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(_imageFile),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.grey[400],
                              )),
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
                    padding: EdgeInsets.only(
                        bottom: 10,
                        left: MediaQuery.of(context).size.width * 0.2),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1),
                          child: Ink(
                              width: 60.0,
                              height: 60.0,
                              decoration: ShapeDecoration(
                                color: Colors.blue[800],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.crop,
                                  size: 40,
                                ),
                                onPressed: _cropImage,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1),
                          child: Ink(
                              width: 60.0,
                              height: 60.0,
                              decoration: ShapeDecoration(
                                color: Colors.blue[800],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.refresh,
                                  size: 40,
                                ),
                                onPressed: _clear,
                              )),
                        ),
                      ],
                    )),
                if (_fileUploaded)
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                        child: Text(
                      'File Upload Successful',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )),
                  ),
              ]
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_library),
              label: 'Gallery',
            ),
          ],
          onTap: _onItemTapped,
          selectedItemColor: Colors.grey[600],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: InkWell(
            child: Container(
              height: 70,
              width: 70,
              child: Icon(Icons.file_upload, size: 40, color: Colors.white),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue[800],
              ),
            ),
            onTap: () {
              if (_imageFile != null)
                saveImage(_imageFile, databaseReference, pollID);
            }));
  }

  void _onItemTapped(int value) {
    if (value == 0) {
      _pickImage(ImageSource.camera);
    } else {
      _pickImage(ImageSource.gallery);
    }
  }
}
