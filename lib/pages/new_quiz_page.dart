import 'package:flutter/material.dart';

class NewQuizPage extends StatelessWidget {
  const NewQuizPage({super.key, required this.question, required this.options});

  final String question;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text(question), choiceButton()],
        ),
      ),
    );
  }

  Widget choiceButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: MaterialButton(
        onPressed: () {},
        color: Colors.indigo,
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: ListView.builder(
          itemCount: options.length,
          itemBuilder: (_, index) => Text(
            options[index],
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Alike",
              fontSize: 16.0,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
