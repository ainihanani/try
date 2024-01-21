import 'package:flutter/material.dart';
import 'package:learn_apps/models/question_model.dart';
import 'package:learn_apps/pages/result_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.questionList});

  final List<Question> questionList;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  String? selectedAnswer;

  int _index = 0;
  List<String> listOfAnswers = ['', '', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(listOfAnswers.toString()),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                listOfAnswers.length,
                (index) => CircleAvatar(
                      backgroundColor: changeColor(index),
                      radius: 10,
                    ))),
        _buildCard(
          widget.questionList[_index].question,
          widget.questionList[_index].options,
          _index,
        ),
        _buildButton()
      ],
    ));
  }

  bool gotEmpty() => listOfAnswers.any((str) => str == '');

  bool isBeforeAnswered(int index) => listOfAnswers[index] != '';

  bool allNotEmpty() => listOfAnswers.every((element) => element != '');

  bool isAnswered(int index) => listOfAnswers[index] != '';

  Color changeColor(int index) =>
      isAnswered(index) ? Colors.green : Colors.grey;

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: _index != 0
                ? () {
                    setState(() {
                      _index--;
                    });
                  }
                : null,
            child: Text('< Back')),
        ElevatedButton(
            onPressed: (gotEmpty() && _index == (listOfAnswers.length-1))
                ? null
                : () {
                    if (allNotEmpty() && _index == (listOfAnswers.length-1)) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ResultPage(
                          listOFAnswer: listOfAnswers,
                          listOfQuestions: widget.questionList,
                        ),
                      ));
                    } else {
                      setState(() {
                        _index++;
                      });
                    }
                  },
            child: Text(allNotEmpty()
                ? "Done"
                : listOfAnswers[_index] != ''
                    ? 'Next >'
                    : 'Skip >')),
      ],
    );
  }

  Widget _buildCard(String question, List<String> options, int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            RadioListTile.adaptive(
              title: Text(options[0]),
              value: options[0],
              groupValue: listOfAnswers[index],
              onChanged: (answer) {
                setState(() {
                  selectedAnswer = answer as String;
                  listOfAnswers[index] = answer;
                });
              },
            ),
            RadioListTile.adaptive(
              title: Text(options[1]),
              value: options[1],
              groupValue: listOfAnswers[index],
              onChanged: (answer) {
                setState(() {
                  selectedAnswer = answer as String;
                  listOfAnswers[index] = answer;
                });
              },
            ),
            RadioListTile.adaptive(
              title: Text(options[2]),
              value: options[2],
              groupValue: listOfAnswers[index],
              onChanged: (answer) {
                setState(() {
                  selectedAnswer = answer as String;
                  listOfAnswers[index] = answer;
                });
              },
            ),
            RadioListTile.adaptive(
              title: Text(options[3]),
              value: options[3],
              groupValue: listOfAnswers[index],
              onChanged: (answer) {
                setState(() {
                  selectedAnswer = answer as String;
                  listOfAnswers[index] = answer;
                });
              },
            ),

            // _buildButton()
          ],
        ),
      ),
    );
  }
}
