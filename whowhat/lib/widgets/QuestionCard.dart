import 'package:flutter/material.dart';
import 'package:whowhat/widgets/GradientButton.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/model/polls.dart';

Widget Option(id, text) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: TextBox(
      placeholder: text,
      textInputType: TextInputType.text,
      obscureText: false,
      size: 1,
    ),
  );
}

Widget SmallButton(context, text, color, function) {
  return InkWell(
      child: Padding(
          padding: EdgeInsets.only(top: 10, left: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: color,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 30),
                    )),
              ))),
      onTap: function);
}

class QuestionCard extends StatefulWidget {
  final int number;

  QuestionCard({Key key, this.number}) : super(key: key);

  @override
  _MyQuestionCardState createState() => _MyQuestionCardState(this.number);
}

class _MyQuestionCardState extends State<QuestionCard> {
  final int number;

  _MyQuestionCardState(this.number);

  int numOptions = 2;

  final questionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextEditingController pollTitleController =
        new TextEditingController();

    Question question = new Question();

    return SingleChildScrollView(
        child: Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
      child: Column(children: [
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextBox(
                    placeholder: 'Poll Text',
                    textInputType: TextInputType.text,
                    obscureText: false,
                    size: 2,
                    controller: questionController,
                  ),
                ),
                Option(1, 'Option 1'),
                Option(2, 'Option 2'),
                Option(3, 'Option 3'),
                Option(4, 'Option 4'),
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
        Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: GradientButton(
                text: 'Add Question',
              ),
            ))
      ]),
    ));
  }
}
