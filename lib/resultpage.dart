import 'package:flutter/material.dart';
import 'package:learn_apps/homie.dart';

class resultpage extends StatefulWidget {
  final int marks;

  resultpage({required Key key, required this.marks}) : super(key: key);

  @override
  _resultpageState createState() => _resultpageState();
}

class _resultpageState extends State<resultpage> {
  late String image;
  late String message;

  @override
  void initState() {
    super.initState();
    if (widget.marks < 20) {
      image = "assets/images/bad.png";
      message = "You Should Try Hard..\n" + "You Scored ${widget.marks}";
    } else if (widget.marks < 35) {
      image = "assets/images/good.png";
      message = "You Can Do Better..\n" + "You Scored ${widget.marks}";
    } else {
      image = "images/success.png";
      message = "You Did Very Well..\n" + "You Scored ${widget.marks}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image.asset(
                            image,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 15.0,
                      ),
                      child: Center(
                        child: Text(
                          message,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Quando",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => homepage(),
                    ));
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  splashColor: Colors.indigoAccent,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

OutlineButton({required Null Function() onPressed, required Text child, required EdgeInsets padding, required BorderSide borderSide, required MaterialAccentColor splashColor}) {
}
