import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> _questions = [];
  var correctAnswer;
  var answers = [];
  var answerChosen = null;
  var unsetButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.white,
    onPrimary: Colors.black,
    side: BorderSide(width: 2, color: Colors.black),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: EdgeInsets.all(20),
  );

  var correctButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.green,
    onPrimary: Colors.black,
    side: BorderSide(width: 2, color: Colors.black),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: EdgeInsets.all(20),
  );

  var incorrectButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.red,
    onPrimary: Colors.black,
    side: BorderSide(width: 2, color: Colors.black),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: EdgeInsets.all(20),
  );

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response = await http
        .get(Uri.parse('https://opentdb.com/api.php?amount=1&type=multiple'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      setState(() {
        _questions = List<Map<String, dynamic>>.from(responseData['results']);

        // Extract the correct answer
        correctAnswer = responseData['results'][0]['correct_answer'];

        // Extract the incorrect answers
        var incorrectAnswers =
            List<String>.from(responseData['results'][0]['incorrect_answers']);

        // Combine correct and incorrect answers into a single list
        answers = [correctAnswer, ...incorrectAnswers];
        answers.shuffle();

        answerChosen = null;
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          },
        ),
        title: Text('Quiz Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var question in _questions)
              Text(
                question['question'],
                style: TextStyle(fontSize: 15.0),
              ),
            SizedBox(height: 30.0), // Add SizedBox for spacing
            for (var answer in answers)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (answerChosen != null) {
                        return;
                      }
                      setState(() {
                        answerChosen = answer;
                      });
                      if (answer == correctAnswer) {
                        print("Correct");
                      } else {
                        print("Incorrect");
                      }
                    },
                    style: answerChosen == null
                        ? unsetButtonStyle
                        : answer == correctAnswer
                            ? correctButtonStyle
                            : answer == answerChosen
                                ? incorrectButtonStyle
                                : unsetButtonStyle,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(answer),
                    ),
                  ),
                  SizedBox(height: 20.0), // Add SizedBox for spacing
                ],
              ),
            SizedBox(height: 20.0), // Add SizedBox for spacing
            if (answerChosen != null)
              ElevatedButton(
                onPressed: () {
                  answerChosen != null ? fetchQuestions() : () => {};
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2, color: Colors.black),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(30),
                ),
                child: Text("Next"),
              )
          ],
        ),
      ),
    );
  }
}
