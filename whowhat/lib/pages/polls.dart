import 'package:flutter/material.dart';
import 'package:whowhat/widgets/PollCard.dart';

class MyPolls extends StatefulWidget {
  @override
  _MyPollsState createState() => _MyPollsState();
}

class _MyPollsState extends State<MyPolls> {
  TextEditingController codeInput = new TextEditingController();
  String _statusLabel = "";

  _updateStatus(String message) {
    setState(() {
      _statusLabel = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    List<Widget> getPolls() {
      List<Widget> list = new List<Widget>();
      for (var i = 0; i < 20; i++) {
        list.add(PollCard(title: 'My poll', description: '3 questions'));
      }
      return list;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My WHoWhats'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context, false),
        ),
        backgroundColor: Colors.blue[800],
      ),
      //resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getPolls(),
            ),
          ),
        ),
      ),

      floatingActionButton: keyboardIsOpened
          ? null
          : InkWell(
              child: Container(
                height: 70,
                width: 70,
                child: Icon(Icons.add_outlined, size: 35, color: Colors.white),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [Color(0xFF3186E3), Color(0xFF1D36C4)]),
                ),
              ),
              onTap: () {},
            ),
    );
  }
}
