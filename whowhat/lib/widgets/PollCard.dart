import 'package:flutter/material.dart';
import 'package:whowhat/widgets/GradientButton.dart';
import 'package:whowhat/widgets/TextPanel.dart';

class PollCard extends StatelessWidget {
  // final Gradient gradient;
  //final Image image;
  final String title;
  final String description;
  final String imageURL;
  final Function onTap;

  PollCard({Key key, this.title, this.description, this.imageURL, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Container(
          width: width * 0.9,
          height: height * 0.2,
          child: Row(children: <Widget>[
            Container(
                height: height * 0.2,
                width: width * 0.8 * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageURL),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Colors.grey[400],
                )),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        this.title,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(this.description),
                    ),
                  ]),
            ),
          ]),
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
          width: width * 0.9,
          height: height * 0.2,
          alignment: Alignment.centerRight,
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  bottom: height * 0.03,
                  top: height * 0.02,
                  right: height * 0.005),
              child: IconButton(
                  icon: Icon(
                    Icons.create_rounded,
                    color: Colors.blue[400],
                    size: 30,
                  ),
                  onPressed: () {}),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: height * 0.025, right: height * 0.005),
              child: IconButton(
                icon: Icon(
                  Icons.play_circle_fill,
                  color: Colors.green[400],
                  size: 35,
                ),
                onPressed: () {
                  onTap();
                },
              ),
            )
          ]))
    ]);
  }
}
