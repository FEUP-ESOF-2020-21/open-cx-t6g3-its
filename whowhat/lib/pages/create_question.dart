import 'package:flutter/material.dart';
import 'package:whowhat/widgets/QuestionCard.dart';

class CreateQuestion extends StatefulWidget {
  CreateQuestion({Key key}) : super(key: key);

  @override
  _MyListQuestions createState() => _MyListQuestions();
}

class _MyListQuestions extends State<CreateQuestion> {
  final List<String> entries = <String>['Ola', 'Test', 'texto'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Create WHoWhat"),
          backgroundColor: Colors.blue[800],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pop(context, false),
          )),
      backgroundColor: Colors.white,
      body: QuestionCard(),
    );
  }
}
