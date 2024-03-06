import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:flashcard/services/Question.dart";
import 'package:get/get_navigation/get_navigation.dart';

class QuestionRepository extends GetxController{
  static QuestionRepository get instance => Get.find();

  static final _db = FirebaseFirestore.instance;

  createQuestion(Question question) async {
    await _db.collection("Quiz").add(question.toJson()).whenComplete(
            () => Get.snackbar("Success!", "Your question has been successfully added!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black.withOpacity(0.1),
              colorText: Colors.white,)
    ).catchError((error, stacktrace){
      Get.snackbar("Error", "Something went wrong. Try Again!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<Question> getQuestionDetails() async {
    final snapshot = await _db.collection("Quiz").where("Correct", isEqualTo: 1).get();
    final questionData = snapshot.docs.map((e) => Question.fromSnapshot(e)).single;
    return questionData;
  }

  static Future<List<Question>> allQuestion() async {
    final snapshot = await _db.collection("Quiz").get();
    print("questions get");
    final questionData = snapshot.docs.map((e) => Question.fromSnapshot(e)).toList();
    print("Questions converted to list");
    return questionData;
  }
}
