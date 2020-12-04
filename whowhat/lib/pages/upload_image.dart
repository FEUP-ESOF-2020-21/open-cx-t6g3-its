import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<File> _pickImage(ImageSource source) async {
  final _picker = ImagePicker();
  final pickedFile = await _picker.getImage(
    source: source,
    maxHeight: 500,
    imageQuality: 50,
  );
  final File selected = File(pickedFile.path);

  return selected;
}

Future<String> uploadFile(File _image, String pollID) async {
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child('pollImages/$pollID');
  StorageUploadTask uploadTask = storageReference.putFile(_image);
  await uploadTask.onComplete;

  String returnURL;
  await storageReference.getDownloadURL().then((fileURL) {
    returnURL = fileURL;
  });
  return returnURL;
}

Future<File> cropImage(File imageFile) async {
  File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
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

  return croppedFile;
}
