import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  // final Gradient gradient;
  final double width;
  final bool isEnabled;
  final Function onPressed;
  final String text;
  final EdgeInsets padding;

  const GradientButton(
      {Key key,
      this.isEnabled,
      this.text,
      this.width,
      this.onPressed,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var realPadding;
    if (this.padding == null) {
      realPadding = EdgeInsets.fromLTRB(0, 0, 0, 0);
    } else {
      realPadding = padding;
    }

    return Padding(
      padding: realPadding,
      child: Container(
        height: 62,
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
              borderRadius: new BorderRadius.circular(15)),
          color: Colors.transparent,
          child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: onPressed,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Center(
                  child: Text(
                    this.text,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 22),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
