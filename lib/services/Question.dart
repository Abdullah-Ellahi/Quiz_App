import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  late String question;
  late String opt1;
  late String opt2;
  late String opt3;
  late String opt4;
  late String correct;

  Question(
      this.question, this.opt1, this.opt2, this.opt3, this.opt4, this.correct);

  toJson() {
    return {
      "Question": question,
      "Option1": opt1,
      "Option2": opt2,
      "Option3": opt3,
      "Option4": opt4,
      "Correct": correct,
    };
  }

  Question.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    this.question = data['Question'] as String;
    this.opt1 = data['Option1'] as String;
    this.opt2 = data['Option2'] as String;
    this.opt3 = data['Option3'] as String;
    this.opt4 = data['Option4'] as String;
    this.correct = data['Correct'].toString();
  }
}
