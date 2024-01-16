import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_apps/resultpage.dart';

class getjson extends StatelessWidget {
  String langname;
  getjson(this.langname);
  late String assettoload;  // Declare as late

   void setasset() {
    if (langname == "Quiz Basic Shortcut Keyboard") {
      assettoload = "assets/python.json";
    } else if (langname == "Quiz Basic Computer Components") {
      assettoload = "assets/java.json";
    } else {
      // For any other language name, default to Python for now.
      assettoload = "assets/python.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    setasset();
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text("Loading"),
            ),
          );
        } else {
          return quizpage(key: UniqueKey(), mydata: mydata); // Add key here
        }
      },
    );
  }
}

class quizpage extends StatefulWidget {
  final List mydata;

  quizpage({required Key key, required this.mydata}) : super(key: key);

  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<quizpage> {
  final List mydata;

  _quizpageState(this.mydata);

  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  bool disableAnswer = false;
  int j = 1;
  int timer = 30;
  String showtimer = "30";
  late List<int> random_array;  // Declare as late

  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  bool canceltimer = false;

  void genrandomarray() {
    var distinctIds = <int>[];
    var rand = Random();
    for (int i = 0;;) {
      distinctIds.add(rand.nextInt(10));
      random_array = distinctIds.toSet().toList();
      if (random_array.length < 10) {
        continue;
      } else {
        break;
      }
    }
    print(random_array);
  }

  @override
  void initState() {
    super.initState();
    starttimer();
    genrandomarray();
  }

  void starttimer() {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      if (timer < 1) {
        t.cancel();
        nextquestion();
      } else if (canceltimer == true) {
        t.cancel();
      } else {
        timer = timer - 1;
      }
      setState(() {
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 30;
    if (j < 10) {
      i = random_array[j];
      j++;
    } else {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (context) => resultpage(key: UniqueKey(), marks: marks), // Added UniqueKey()
));

    }
    setState(() {
      btncolor = {
        "a": Colors.indigoAccent,
        "b": Colors.indigoAccent,
        "c": Colors.indigoAccent,
        "d": Colors.indigoAccent,
      };
      disableAnswer = false;
    });
    starttimer();
  }

  void checkanswer(String k) {
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      marks = marks + 5;
      colortoshow = right;
    } else {
      colortoshow = wrong;
    }
    setState(() {
      btncolor[k] = colortoshow;
      canceltimer = true;
      disableAnswer = true;
    });
    Timer(Duration(seconds: 2), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btncolor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  mydata[0][i.toString()],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Satisfy",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: AbsorbPointer(
                absorbing: disableAnswer,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choicebutton('a'),
                      choicebutton('b'),
                      choicebutton('c'),
                      choicebutton('d'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showtimer,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
