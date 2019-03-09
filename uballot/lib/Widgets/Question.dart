import 'package:flutter/material.dart';

class Question {
  String question = '';
  String A;
  String B;
  String C;
  String D;
  String E;
  String correctAnswer;

  questionToJson() {
    return {
      "question":question,
    "A": A,
      "B": B,
      "C": C,
      "D": D,
      "E": E,
      "correctAnswer": correctAnswer,
    };
  }
}