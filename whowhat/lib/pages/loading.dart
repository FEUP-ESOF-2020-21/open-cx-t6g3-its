import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLoading extends StatefulWidget {
  MyLoading({Key key}) : super(key: key);

  @override
  _MyLoadingState createState() => _MyLoadingState();
}

class _MyLoadingState extends State<MyLoading> {
  _MyLoadingState();

  @override
  Widget build(BuildContext context) {
    return Text('dasd');
  }
}

Scaffold loadingScaffold(BuildContext context) {
  return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: Text('dasd'));
}
