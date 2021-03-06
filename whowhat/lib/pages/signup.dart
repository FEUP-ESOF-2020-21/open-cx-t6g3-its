import 'package:flutter/material.dart';
import 'package:whowhat/pages/login.dart';
import 'package:whowhat/widgets/AppIcon.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/widgets/GradientButton.dart';
import 'package:whowhat/pages/menu.dart';
import 'package:whowhat/widgets/database/auth.dart';

class MySignup extends StatefulWidget {
  MySignup({Key key}) : super(key: key);

  @override
  _MySignupState createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
  final AuthService _auth = AuthService();

  String _statusLabel = "";

  _updateStatus(String message) {
    setState(() {
      _statusLabel = message;
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Center(
          child: Container(
            height: screenHeight * 0.9,
            width: screenWidth * 0.9,
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          _statusLabel,
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Roboto',
                              fontSize: 16),
                        )),
                    /*Image(image: AssetImage('assets/images/login.png')),*/
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: TextBox(
                        icon: Icons.email_rounded,
                        placeholder: 'Email',
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: TextBox(
                        icon: Icons.lock_rounded,
                        placeholder: 'Password',
                        controller: passwordController,
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: TextBox(
                        icon: Icons.person,
                        placeholder: 'Name',
                        controller: nameController,
                        textInputType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: TextBox(
                        icon: Icons.cases,
                        placeholder: 'Job',
                        controller: jobController,
                        textInputType: TextInputType.name,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.01),
                        child: Text(
                          'or Register In with:',
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: InkWell(
                          child: Container(
                            height: 62,
                            width: screenWidth * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFFECECEC),
                            ),
                            child:
                                Icon(AppIcons.google, color: Color(0xFF9B9B9B)),
                          ),
                          onTap: () async {
                            _auth.signInWithGoogle();
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: GradientButton(
                        text: 'Register',
                        onPressed: () async {
                          dynamic result = await _auth.registerWithEmail(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                              jobController.text);
                          if (result != null) {
                            _updateStatus(result);
                          } else {
                            print('signed in');
                            print(result);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyMenu(),
                                ));
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Do you have an account?',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                            InkWell(
                              child: Text(
                                ' Log In ',
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyLogin(),
                                    ));
                              },
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
