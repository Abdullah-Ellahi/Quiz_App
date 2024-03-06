import 'package:firebase_core/firebase_core.dart';
import 'package:flashcard/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flashcard/controller/dependency_injection.dart';
import 'package:flashcard/pages/add_question.dart';
import 'package:flashcard/pages/home.dart';
import 'package:flashcard/pages/loading.dart';

void main() {

  runApp(GetMaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/add_question': (context) => AddQuestion(),
    },
  ));
}
Widget loadingBuilder(BuildContext context) => Loading();

Widget homeBuilder(BuildContext context) => Home();

Widget chooseLocationBuilder(BuildContext context) => AddQuestion();
