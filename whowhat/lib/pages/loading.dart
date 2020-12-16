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
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color(0xFF365ED4),
        ));
  }
}

Scaffold loadingScaffold(BuildContext context) {
  return Scaffold(
    //resizeToAvoidBottomPadding: false,
    body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xFF365ED4),
      ),
      child: Column(children: <Widget>[
        Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width / 2),
            child: Align(
                alignment: Alignment.center,
                child: Image(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    image: AssetImage('assets/images/whowhat logo.png')))),
      ]),
    ),
  );
}
