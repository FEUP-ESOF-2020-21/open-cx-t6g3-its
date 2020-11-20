import 'package:flutter/material.dart';
import 'package:whowhat/pages/login.dart';
import 'package:whowhat/widgets/AppIcon.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/widgets/GradientButton.dart';
import 'package:whowhat/pages/menu.dart';
import 'package:whowhat/widgets/database/auth.dart';

class MyCreatePoll extends StatefulWidget {
  MyCreatePoll({Key key}) : super(key: key);

  @override
  _MyCreatePollState createState() => _MyCreatePollState();
}

class _MyCreatePollState extends State<MyCreatePoll> {
  final AuthService _auth = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                children: <Widget>[
                  /*Image(image: AssetImage('assets/images/login.png')),*/

                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      child: (Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '  Name: ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextBox(
                      controller: passwordController,
                      textInputType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '  Description: ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        minLines: 5, //Normal textInputField will be displayed
                        maxLines: 5,
                      )),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GradientButton(
                      text: 'Create WHoWhat',
                      onPressed: () {
                        print('signed in');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
