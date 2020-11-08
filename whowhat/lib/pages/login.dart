import 'package:flutter/material.dart';
import 'package:whowhat/widgets/AppIcon.dart';
import 'package:whowhat/widgets/TextBox.dart';
import 'package:whowhat/widgets/GradientButton.dart';

class MyLogin extends StatefulWidget {
  MyLogin({Key key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
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
                  Image(image: AssetImage('assets/images/login.png')),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextBox(
                      icon: Icons.email_rounded,
                      placeholder: 'Email',
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextBox(
                      icon: Icons.lock_rounded,
                      placeholder: 'Password',
                      obscureText: true,
                      textInputType: TextInputType.visiblePassword,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'or Login In with:',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      )),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              child: Container(
                                height: 62,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFFECECEC),
                                ),
                                child: Icon(AppIcons.google,
                                    color: Color(0xFF9B9B9B)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              child: Container(
                                height: 62,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFFECECEC),
                                ),
                                child: Icon(AppIcons.facebook,
                                    color: Color(0xFF9B9B9B)),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GradientButton(
                      text: 'Sign in',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
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
                          Text(
                            ' Sign Up ',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          )
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
