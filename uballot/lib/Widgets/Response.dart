import 'package:flutter/material.dart';

class Response {
  String question = '';
  String A;
  String B;
  String C;
  String D;
  String E;
  String FeedBack;
  String correctAnswer;
  String response;

 // String quizName;
 // String quizQuestion;
  //String className;

  responseToJson() {
    return {
              "question":question,
              "A": A,
              "B": B,
              "C": C,
              "D": D,
              "E": E,
              "FeedBack": FeedBack,
              "correctAnswer": correctAnswer,
              "response" : response,

    };
  }

  responseFromJson(Map<dynamic, dynamic> json, String qName, String qQuestion) {
    return {

            "question":json[qName][qQuestion]['question'],
            "A": json['A'] == null ? '' : json[qName][qQuestion]['A'],
            "B": json['B'] == null ? '' : json[qName][qQuestion]['B'],
            "C": json['C'] == null ? '' : json[qName][qQuestion]['C'],
            "D": json['D'] == null ? '' : json[qName][qQuestion]['D'],
            "E": json['E'] == null ? '' : json[qName][qQuestion]['E'],
            "FeedBack": json['FeedBack'] == null ? '' : json[qName][qQuestion]['FeedBack'],
            "correctAnswer": json['correctAnswer'] == null ? '' : json[qName][qQuestion]['correctAnswer'],
            "response": json['response'] == null ? '' : json[qName][qQuestion]['response'],

    };
  }
}