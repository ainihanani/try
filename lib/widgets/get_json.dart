
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_apps/models/question_model.dart';
import 'package:learn_apps/pages/question_page.dart';

class GetJson extends StatefulWidget {
  String langName;

  GetJson(this.langName, {super.key});

  @override
  State<GetJson> createState() => _GetJsonState();
}

class _GetJsonState extends State<GetJson> {
  String? assetToLoad;

  // Declare as late
  void setAsset() {
    if (widget.langName == "Quiz Basic Shortcut Keyboard") {
      assetToLoad = "questions_basic_keyboard_shortcut";
    } else if (widget.langName == "Quiz Basic Computer Components") {
      assetToLoad = "questions_basic_computer_comp";
    } else {
      assetToLoad = "questions_basic_computer_comp";
    }
  }

  late var db;
  late Future<List<Question>> questions;

  @override
  void initState() {
    super.initState();
    setAsset();
    db = FirebaseFirestore.instance;
    questions = getQuestionsFromFirestore(assetToLoad!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question'),
      ),
      body: FutureBuilder<List<Question>>(
        future: questions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Question> questions = snapshot.data ?? [];
            // Now you can use the 'questions' list in your UI
            return QuestionPage(questionList: questions);
          }
        },
      ),
    );
  }
}
