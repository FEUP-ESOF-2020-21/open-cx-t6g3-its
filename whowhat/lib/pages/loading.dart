import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
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
