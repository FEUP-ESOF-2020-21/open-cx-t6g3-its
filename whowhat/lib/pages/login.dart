import 'package:flutter/material.dart';
import 'package:whowhat/pages/signup.dart';
import 'package:whowhat/widgets/AppIcon.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/widgets/GradientButton.dart';
import 'package:whowhat/pages/menu.dart';
import 'package:whowhat/widgets/database/auth.dart';

class MyLogin extends StatefulWidget {
  MyLogin({Key key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  checkSignIn() async {
    dynamic result = await _auth.signInWithEmail(
        emailController.text, passwordController.text);
    if (result == null) {
      print("Error signing in");
    } else {
      print('signed in');
      print(result);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyMenu(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.05),
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                children: <Widget>[
                  Image(image: AssetImage('assets/images/login.png')),
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
                      padding: EdgeInsets.only(top: screenHeight * 0.01),
                      child: Text(
                        'or Login In with:',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      )),
                  Padding(
                    padding: EdgeInsets.all(screenHeight * 0.01),
                    child: Padding(
                      padding: EdgeInsets.all(screenHeight * 0.005),
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
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenHeight * 0.01),
                    child: GradientButton(
                      text: 'Sign In',
                      onPressed: () async {
                        checkSignIn();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.01),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Do you need an account?',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          InkWell(
                            child: Text(
                              ' Sign Up ',
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MySignup(),
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
    );
  }
}
