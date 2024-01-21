import 'package:flutter/material.dart';
import 'package:learn_apps/homie.dart';
import 'package:learn_apps/models/question_model.dart';

class ResultPage extends StatelessWidget {
  const ResultPage(
      {super.key, required this.listOFAnswer, required this.listOfQuestions});

  final List<String> listOFAnswer;
  final List<Question> listOfQuestions;

  @override
  Widget build(BuildContext context) {
    int calculateMark() {
      int mark = 0;
      for (int i = 0; i < listOFAnswer.length; i++) {
        if (listOFAnswer[i] == listOfQuestions[i].answer) {
          mark++;
        }
      }
      return mark;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "WELL DONE!",
              style: TextStyle(fontSize: 40),
            ),
            Text(
              'Your score: ${calculateMark()}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => homepage()));
                  Navigator.pop(context);
                },
                child: Text('Im Done'))
          ],
        ),
      ),
    );
  }
}
