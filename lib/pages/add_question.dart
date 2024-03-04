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
      int.parse(_correctOptionController.text),
    );

    // Add the question data to the 'questions' collection in Firebase
    await _firestore.collection('questions').add(question.toJson());

    // Show success alert
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: 'Question added successfully!',
      onConfirmBtnTap: () {
        // You can add further actions after the user closes the alert
        // For example, navigate back to the previous screen.
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Add a Question',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Question'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _option1Controller,
                decoration: InputDecoration(labelText: 'Option 1'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _option2Controller,
                decoration: InputDecoration(labelText: 'Option 2'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _option3Controller,
                decoration: InputDecoration(labelText: 'Option 3'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _option4Controller,
                decoration: InputDecoration(labelText: 'Option 4'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _correctOptionController,
                decoration: InputDecoration(labelText: 'Correct Option (1, 2, 3, or 4)'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _addQuestionToFirebase,
                child: Text('Add Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
