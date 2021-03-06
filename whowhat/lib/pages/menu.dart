import 'package:flutter/material.dart';
import 'package:whowhat/pages/mypolls.dart';
import 'package:whowhat/pages/profile.dart';
import 'package:whowhat/pages/settings.dart';
import 'package:whowhat/widgets/AppIcon.dart';
import 'package:whowhat/widgets/GradientButton.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/widgets/TextPanel.dart';
import 'package:whowhat/pages/session_loop.dart';
import 'package:whowhat/widgets/database/session_connection.dart';
import 'package:whowhat/widgets/database/db_polls.dart';

class MyMenu extends StatefulWidget {
  @override
  _MyMenuState createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
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

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.2),
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
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                ],
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextBox(
                    placeholder: "Insert code here",
                    icon: Icons.vpn_key,
                    controller: codeInput,
                    textInputType: TextInputType.number,
                  ),
                  GradientButton(
                      text: 'Connect',
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      onPressed: () async {
                        String code = codeInput.text;
                        if (code == null || code == "") {
                          _updateStatus("You need to insert a code!");
                        } else {
                          if (await availableSession(code)) {
                            await joinSession(code);
                            String title = await getSessionTitle(code);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SessionLoop(
                                      id: codeInput.text, title: title)),
                            );
                          } else {
                            _updateStatus("Session is not available!");
                          }
                        }
                      }
                      //connect(context),
                      ),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        _statusLabel,
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Roboto',
                            fontSize: 16),
                      ))
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
            icon: Icon(Icons.info_outline),
            label: 'Info',
          ),
        ],
        selectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: keyboardIsOpened
          ? null
          : InkWell(
              child: Container(
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPolls(),
                    ));
              }),
    );
  }

  void _onItemTapped(int value) {
    if (value == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyProfile(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MySettings(),
          ));
    }
  }
}
