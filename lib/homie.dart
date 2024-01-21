import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_apps/models/quiz_model.dart';

import 'widgets/custom_card.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late var db;

  @override
  void initState() {
    super.initState();

    /// Initialize an instance of Cloud Firestore
    db = FirebaseFirestore.instance;

    /// Read data from the firebase to get quiz type
    ///   db.collection("quiz_type").get().then((event) {
    ///   for (var doc in event.docs) {
    ///     print("${doc.id} => ${doc.data()}");
    ///     print('################');
    ///   }
    /// });

    /// Add data
    ///     db.collection("q_basic_computer_components")
    ///     .set(questions)
    ///     .then((documentSnapshot) =>
    ///         print("Added Data with ID: ${documentSnapshot.id}"));
  }

  Future<void> addQuestionsToFirestore() async {
    try {
      // Read the JSON file
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/basic_computer_components/questions.json');

      // Parse the JSON string
      List<dynamic> questionsData = json.decode(jsonString);

      // Reference to the Firestore collection
      CollectionReference questionsCollection = FirebaseFirestore.instance
          .collection('questions_basic_computer_comp');

      // Loop through the questionsData and add each question to Firestore
      for (int i = 0; i < questionsData.length; i++) {
        // Set a custom ID for each document (e.g., using the index)
        String documentId = 'question_$i';

        // Create a reference with the custom ID
        DocumentReference documentReference =
            questionsCollection.doc(documentId);

        // Set the data for the document
        await documentReference.set({
          'question': questionsData[i]['question'],
          'options': questionsData[i]['options'],
          'answer': questionsData[i]['answer'],
        });
      }

      print('Questions added to Firestore successfully');
    } catch (error) {
      print('Error adding questions to Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    final quiz = FirebaseFirestore.instance
        .collection('quiz_type')
        .withConverter<Quiz>(
            fromFirestore: (snapshot, _) => Quiz.fromJson(snapshot.data()!),
            toFirestore: (quiz, _) => quiz.toJson());

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quizstar",
            style: TextStyle(
              fontFamily: "Quando",
            ),
          ),
        ),
        body: FirestoreListView<Quiz>(
          query: quiz,
          itemBuilder: (context, snapshot) {
            Quiz quizType = snapshot.data();
            return CustomCard(
              langName: quizType.title,
              image: quizType.images,
              description: quizType.description,
            );
          },
        ));
  }
}
