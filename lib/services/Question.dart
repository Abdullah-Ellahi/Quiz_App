class Question{
  late String question;
  late String opt1;
  late String opt2;
  late String opt3;
  late String opt4;
  late int correct;

  Question(this.question, this.opt1, this.opt2, this.opt3, this.opt4, this.correct);

  toJson(){
    return{
      "Question" : question,
      "Option1" : opt1,
      "Option2" : opt2,
      "Option3" : opt3,
      "Option4" : opt4,
      "Correct" : correct,
    };
  }
}