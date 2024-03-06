import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flashcard/services/Question.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _questionController = TextEditingController();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();
  final _option3Controller = TextEditingController();
  final _option4Controller = TextEditingController();
  final _correctOptionController = TextEditingController();

  // Function to add question to Firebase
  void _addQuestionToFirebase() async {
    // Get a Firestore instance
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Create a Question object
    Question question = Question(
      _questionController.text,
      _option1Controller.text,
      _option2Controller.text,
      _option3Controller.text,
      _option4Controller.text,
      _correctOptionController.text,
    );

    // Add the question data to the 'questions' collection in Firebase
    await _firestore.collection('Quiz').add(question.toJson());

    // Show success alert
    CoolAlert.show(
      confirmBtnColor: Colors.amber,
      backgroundColor: Colors.amber.shade100,
      context: context,
      type: CoolAlertType.success,
      text: 'Question added successfully!',
      onConfirmBtnTap: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(),
        backgroundColor: Colors.black,
        shape: new RoundedRectangleBorder(
          side: BorderSide(color: Colors.amber),
          borderRadius: new BorderRadius.circular(10)
        )
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.amber,
        title: Text(
          'Add Question',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
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
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    enableSuggestions: true,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _questionController,
                    decoration: InputDecoration(
                      labelText: 'Question',
                      labelStyle: TextStyle(
                        color: Colors.amber,
                      )
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _option1Controller,
                    decoration: InputDecoration(labelText: 'Option 1',
                      labelStyle: TextStyle(
                      color: Colors.amber,
                    )
                  ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _option2Controller,
                    decoration: InputDecoration(labelText: 'Option 2',
                        labelStyle: TextStyle(
                          color: Colors.amber,
                        )
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _option3Controller,
                    decoration: InputDecoration(labelText: 'Option 3',
                        labelStyle: TextStyle(
                          color: Colors.amber,
                        )
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _option4Controller,
                    decoration: InputDecoration(labelText: 'Option 4',
                        labelStyle: TextStyle(
                          color: Colors.amber,
                        )
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _correctOptionController,
                    decoration: InputDecoration(labelText: 'Correct Option',
                        labelStyle: TextStyle(
                          color: Colors.amber,
                        )
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(

                    style: style,
                    onPressed: _addQuestionToFirebase,
                    child: Text(
                        'Add Question',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
