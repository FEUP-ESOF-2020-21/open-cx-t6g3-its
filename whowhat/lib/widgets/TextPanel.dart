import 'package:flutter/material.dart';

class TextPanel extends StatelessWidget {
  // final Gradient gradient;
  final String text;
  final double height;
  final EdgeInsets padding;
  final double width;

  const TextPanel({Key key, this.text, this.height, this.width, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets realPadding;
    if (this.padding == null) {
      realPadding = EdgeInsets.zero;
    } else {
      realPadding = this.padding;
    }

    return Padding(
      padding: realPadding,
      child: Container(
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Color(0xFF3186E3),
              Color(0xFF1D36C4),
            ],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
        ),
        child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50)),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    this.text,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 22),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
