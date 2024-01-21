// class Question {
//   Question({
//     required this.question,
//     required this.options,
//     required this.answer,
//   });
//   late final String question;
//   late final List<String> options;
//   late final String answer;
//
//   Question.fromJson(Map<String, dynamic> json){
//     question = json['question'];
//     options = List.castFrom<dynamic, String>(json['options']);
//     answer = json['answer'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['question'] = question;
//     _data['options'] = options;
//     _data['answer'] = answer;
//     return _data;
//   }
//
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String question;
  final List<String> options;
  final String answer;

  Question({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] ?? '',
      options: (map['options'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      answer: map['answer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'answer': answer,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] ?? '',
      options: (json['options'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      answer: json['answer'] ?? '',
    );
  }


}
Future<List<Question>> getQuestionsFromFirestore(String directory) async {
  CollectionReference questionsCollection =
      FirebaseFirestore.instance.collection(directory);

  QuerySnapshot querySnapshot = await questionsCollection.get();

  List<Question> questions = querySnapshot.docs
      .map((doc) => Question.fromMap(doc.data() as Map<String, dynamic>))
      .toList();

  return questions;
}
