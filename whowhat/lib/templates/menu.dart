import 'package:flutter/material.dart';
import 'package:whowhat/widgets/AppIcon.dart';
import 'package:whowhat/widgets/GradientButton.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/widgets/TextPanel.dart';

class MyMenu extends StatelessWidget {
  TextEditingController codeInput = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 220),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: <Widget>[
                  Image(image: AssetImage('assets/images/conference.png')),
                  Positioned(
                    top: 100,
                    child: TextPanel(
                      text:
                          'Welcome to WHowhat!\n\n\"Let\'s increase the engagement between speakers and participants in a conference.\"',
                      height: 220,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                ],
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextBox(
                    placeholder: "Insert code here",
                    icon: Icons.vpn_key,
                    controller: codeInput,
                  ),
                  GradientButton(
                    text: 'Connect',
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blue[800],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: keyboardIsOpened
          ? null
          : Container(
              height: 80,
              width: 80,
              child: Icon(AppIcons.whowhat, size: 40, color: Colors.white),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [Color(0xFF3186E3), Color(0xFF1D36C4)]),
              ),
            ),
    );
  }
}
