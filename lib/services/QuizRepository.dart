import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:flashcard/services/Question.dart";
import 'package:get/get_navigation/get_navigation.dart';

class QuizRepository extends GetxController{
  static QuizRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

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
}
