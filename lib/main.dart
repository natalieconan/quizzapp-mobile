import 'package:flutter/material.dart';
import 'package:helloworld/LoginScreen.dart';
import 'package:helloworld/QuizScreen.dart';
import 'package:helloworld/HomeScreen.dart';
import 'package:helloworld/SignupScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'login',
      routes: {
        'home': (context) => HomeScreen(),
        'quiz': (context) => QuizScreen(),
        'login': (context) => LoginScreen(),
        'signup': (context) => SignupScreen(),
      },
    );
  }
}
