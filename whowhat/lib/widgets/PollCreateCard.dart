import 'package:flutter/material.dart';
import 'package:whowhat/widgets/TextBox.dart';

Widget Option(id, text) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: TextBox(
      placeholder: text,
      textInputType: TextInputType.text,
      obscureText: false,
      size: 1,
    ),
  );
}

Widget SmallButton(context, text, color, function) {
  return InkWell(
      child: Padding(
          padding: EdgeInsets.only(top: 10, left: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: color,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 30),
                    )),
              ))),
      onTap: function);
}

class PollCreateCard extends StatefulWidget {
  final int number;
  PollCreateCard({Key key, this.number}) : super(key: key);

  @override
  _MyPollCreateCardState createState() => _MyPollCreateCardState(this.number);
}

class _MyPollCreateCardState extends State<PollCreateCard> {
  final int number;

  _MyPollCreateCardState(this.number);

  int numOptions = 2;

  List<Widget> options = [Option(1, 'Option 1'), Option(2, 'Option 2')];

  void _addOption() {
    setState(() {
      if (numOptions < 4) {
        numOptions++;
        options.add(Option(numOptions, 'Option ' + numOptions.toString()));
      }
    });
  }

  List<Widget> _getOptions() {
    return options;
  }

  void _removeOption() {
    setState(() {
      if (numOptions > 2) {
        options.removeLast();
        numOptions--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
      child: Container(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        alignment: Alignment.topLeft,
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.grey[400],
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              this.number.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 30),
                            )),
                      ))),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextBox(
                  placeholder: 'Poll Text',
                  textInputType: TextInputType.text,
                  obscureText: false,
                  size: 2,
                ),
              ),
              Column(children: _getOptions()),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SmallButton(
                          context, '+', Colors.greenAccent, () => _addOption()),
                      SmallButton(context, '-', Colors.redAccent,
                          () => _removeOption()),
                    ],
                  )),
            ],
          ),
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
    );
  }
}
