import 'dart:io';

import 'package:flashcard/services/Question.dart';
import 'package:flashcard/services/QuestionRepository.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Question> questions = [];
  static int score = 0;
  static int currentQuestionIndex = 0;
  static Question currentQuestion = Question(
      "Question?", "Option 1", "Option 2", "Option 3", "Option 4", "Option 1");

  void fetchQuestions() async {
    questions = await QuestionRepository.allQuestion();
    print("questions fetched");

    if (currentQuestionIndex < questions.length) {
      print("currentQuestionIndex: $currentQuestionIndex");
      currentQuestion = questions.elementAt(currentQuestionIndex);
      loadQuestion(questions.elementAt(currentQuestionIndex));
    } else {
      CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.custom,
        confirmBtnColor: Colors.amber,
        backgroundColor: Colors.amber.shade100,

        text:
            'Congratulations!\nYou have attempted all the questions.\nYour final score is $score.',
        onConfirmBtnTap: () {},
      );
    }

    int result = await loadQuestion(questions.elementAt(currentQuestionIndex));

    if (result != 0) {
      CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.info,
        confirmBtnColor: Colors.amber,
        backgroundColor: Colors.amber.shade100,
        text: 'An unexpected error occurred!\nYour final score is $score.',
        onConfirmBtnTap: () {
          exit(1);
        },
      );
    }
  }

// Function to load the current question
  int loadQuestion(Question newCurrent) {
    if (newCurrent != null) {
      setState(() {
        currentQuestion = newCurrent;
      });
      return 0;
    }
    return 1;
  }

  Future<void> selectOption(String selectedOption) async {
    if (currentQuestionIndex < questions.length) {
      bool correct = selectedOption == currentQuestion.correct.toString();
      if (correct) {
        setState(() {
          score += 1;
        });
      }
      await CoolAlert.show(
        barrierDismissible: false,
        confirmBtnColor: Colors.amber,
        backgroundColor: Colors.amber.shade100,
        context: context,
        type: correct ? CoolAlertType.success : CoolAlertType.custom,
        text: correct
            ? "Correct! Your score is $score"
            : "Incorrect! Your score is $score",
        onConfirmBtnTap: () {
        },
      );
      currentQuestionIndex++;
      if (!(currentQuestionIndex < questions.length)) {
        restart();
      } else {
        loadQuestion(questions.elementAt(currentQuestionIndex));
      }
    } else {
      print("currentQuestionIndex < questions.length is false");
      restart();
    }
  }

  void restart() {
    CoolAlert.show(
      barrierDismissible: false,
      context: context,
      type: CoolAlertType.custom,
      confirmBtnColor: Colors.amber,
      backgroundColor: Colors.amber.shade100,
      text:
          'Congratulations!\nYou have attempted all the questions.\nYour final score is $score.',
      onConfirmBtnTap: () {
        setState(() {
          score = 0;
          currentQuestionIndex = 0;
          loadQuestion(questions.elementAt(currentQuestionIndex));
        });
      },
    );
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    if (i == 0) {
      fetchQuestions();
      i++;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.black,
            splashColor: Colors.red,
            highlightColor: Colors.red,
            iconSize: 40,
            onPressed: () {
              Navigator.pushNamed(context, '/add_question');
            },
            icon: Icon(Icons.add),
            tooltip: "Add Question",
          )
        ],
        centerTitle: true,
        title: Text("Flashcard Quiz"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.amber,
            width: 5,
          ),
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        width: MediaQuery.of(context).size.width,
        // height: screenSize.height-91,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 320,
                height: 200,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  // borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber,width: 8)
                ),
                child: Text(
                  currentQuestion.question,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50),
              // ListView for answer options
              Column(
                children: [
                  buildOption(currentQuestion.opt1),
                  SizedBox(height: 20),
                  buildOption(currentQuestion.opt2),
                  SizedBox(height: 20),
                  buildOption(currentQuestion.opt3),
                  SizedBox(height: 20),
                  buildOption(currentQuestion.opt4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build answer options
  Widget buildOption(String option) {
    return SizedBox(
      height: 70,
      width: 320,
      child: ElevatedButton(
        onPressed: () {
          selectOption(option);
        },
        style: ButtonStyle(
          enableFeedback: true,
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.pressed)) {
              // Pressed color
              return Colors.amber;
            } else {
              // Default color
              return Colors.amber.shade100;
            }
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.amber, width: 8),
            ),
          ),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}
