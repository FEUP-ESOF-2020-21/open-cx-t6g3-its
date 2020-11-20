import 'package:flutter/material.dart';
import 'package:whowhat/widgets/TextBox.dart';

class PollCreateCard extends StatelessWidget {
  final int number;
  PollCreateCard({Key key, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
      child: Container(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        alignment: Alignment.topLeft,
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.grey[400],
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              this.number.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 30),
                            )),
                      ))),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextBox(
                  placeholder: 'Poll Text',
                  textInputType: TextInputType.text,
                  obscureText: false,
                  size: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextBox(
                  placeholder: 'Option 1',
                  textInputType: TextInputType.text,
                  obscureText: false,
                  radio: true,
                  size: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextBox(
                  placeholder: 'Option 2',
                  textInputType: TextInputType.text,
                  obscureText: false,
                  radio: true,
                  size: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextBox(
                  placeholder: 'Option 3',
                  textInputType: TextInputType.text,
                  obscureText: false,
                  radio: true,
                  size: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextBox(
                  placeholder: 'Option 4',
                  textInputType: TextInputType.text,
                  obscureText: false,
                  radio: true,
                  size: 1,
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
    );
  }
}
