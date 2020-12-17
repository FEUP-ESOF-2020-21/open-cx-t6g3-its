import 'package:flutter/material.dart';

class MySettings extends StatelessWidget {
  MySettings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            title: Text("About Us"),
            backgroundColor: Colors.blue[800],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context, false),
            )),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, right: width * 0.04),
            child: Container(
              width: width * 0.8,
              height: height * 0.8,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: height * 0.02),
                      child: Center(
                          child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.05, bottom: height * 0.010),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    alignment: Alignment.center,
                                    width: 200,
                                    height: 200,
                                    image: AssetImage(
                                        'assets/images/whowhatlogo.png')),
                                Text(
                                  "WHoWhat",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.08),
                                  child: Text(
                                    "Developed by",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.02),
                                  child: Text(
                                    "Emanuel Trigo",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                                Text(
                                  "Muriel Pinho",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto'),
                                ),
                                Text(
                                  "Rodrigo Reis",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.1),
                                  child: Text(
                                    "©2020 ITS Team",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                                Text(
                                  "Version 1.0",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto'),
                                ),
                              ]),
                        ),
                      )))
                ],
              ),
            ),
          )
        ])));
  }
}
