import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int score = 0; // Variable to store the score

  // Function to handle the selection of an option
  void selectOption(String selectedOption) {
    // Check if the selected option is correct
    if (selectedOption == "1947") {
      // If correct, add 1 to the score
      setState(() {
        score += 1;
      });
    }

    // Display a message with the current score
    CoolAlert.show(
      confirmBtnColor: Colors.amber,
      backgroundColor: Colors.amber.shade100,
      context: context,
      type: selectedOption == "1947" ? CoolAlertType.success : CoolAlertType.error,
      text: selectedOption == "1947"
          ? "Correct! Your score is $score"
          : "Incorrect! Your score is $score",
      onConfirmBtnTap: () {
        // You can add further actions after the user closes the alert
        // For example, move to the next question or reset the game.
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 320,
                    height: 200,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "In what year Pakistan became an independent state?",
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
                      buildOption("1947"),
                      SizedBox(height: 20),
                      buildOption("1965"),
                      SizedBox(height: 20),
                      buildOption("1971"),
                      SizedBox(height: 20),
                      buildOption("Not Yet"),
                    ],
                  ),
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
        onPressed: () => selectOption(option),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
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
