import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  // final Gradient gradient;
  final String placeholder;
  final IconData icon;
  final TextEditingController controller;

  const TextBox({Key key, this.placeholder, this.icon, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          color: Colors.transparent,
        ));

    final focusBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          width: 2,
          color: Colors.blue[400],
        ));

    var preIcon;
    if (this.icon != null) {
      preIcon = Icon(
        this.icon,
        color: Color(0xFF9B9B9B),
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(
        hintColor: Colors.transparent,
      ),
      child: TextFormField(
        controller: this.controller,
        decoration: InputDecoration(
            focusedBorder: focusBorder,
            border: border,
            //placeholder style
            hintStyle: TextStyle(
              color: Color(0xFF9B9B9B),
              fontFamily: "Roboto",
            ),
            filled: true,
            prefixIcon: preIcon,
            fillColor: Color(0xFFECECEC),
            hintText: this.placeholder),
        textAlign: TextAlign.justify,
        style: TextStyle(
            color: Color(0xFF9B9B9B), fontFamily: "Roboto", fontSize: 22),
      ),
    );
  }
}
