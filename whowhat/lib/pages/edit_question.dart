import 'package:flutter/material.dart';
import 'package:whowhat/widgets/GradientButton.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/widgets/database/db_polls.dart';

Widget Option(id, text, optionController) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: TextBox(
      placeholder: text,
      textInputType: TextInputType.text,
      obscureText: false,
      size: 1,
      controller: optionController,
    ),
  );
}

class EditQuestion extends StatefulWidget {
  final String id;
  // final Map<String, dynamic> info;

  EditQuestion({Key key, this.id}) : super(key: key);

  @override
  _MyListQuestions createState() => _MyListQuestions(this.id);
}

class _MyListQuestions extends State<EditQuestion> {
  // final Map<String, dynamic> info;
  final option1Controller = new TextEditingController();
  final option2Controller = new TextEditingController();
  final option3Controller = new TextEditingController();
  final option4Controller = new TextEditingController();

  final questionController = new TextEditingController();

  @override
  void initState() {}

  final String id;

  _MyListQuestions(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("WHoWhat Questions"),
          backgroundColor: Colors.blue[800],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pop(context, false),
          )),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.05),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
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
                    Option(1, 'option 1', option1Controller),
                    Option(2, 'option 2', option2Controller),
                    Option(3, 'option 3', option3Controller),
                    Option(4, 'option 4', option4Controller),
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
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: GradientButton(
                    text: 'Add Question',
                    onPressed: () async {
                      List<String> options = [];
                      options.add(option1Controller.text);
                      options.add(option2Controller.text);
                      options.add(option3Controller.text);
                      options.add(option4Controller.text);

                      await addQuestion(
                          this.id, questionController.text, options);

                      Navigator.pop(context, false);
                    },
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
