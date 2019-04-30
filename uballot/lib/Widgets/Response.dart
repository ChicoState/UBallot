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

  responseFromJson(Map<dynamic, dynamic> json) {
    print(json.toString());
    Map<dynamic, dynamic> r = {

            "question":json['question'],
            "A": json['A'] == null ? '' : json['A'],
            "B": json['B'] == null ? '' : json['B'],
            "C": json['C'] == null ? '' : json['C'],
            "D": json['D'] == null ? '' : json['D'],
            "E": json['E'] == null ? '' : json['E'],
            "FeedBack": json['FeedBack'] == null ? '' : json['FeedBack'],
            "correctAnswer": json['correctAnswer'] == null ? '' : json['correctAnswer'],
            "response": json['response'] == null ? '' : json['response'],

    };
    print("R: "+r.toString());
    return r;
  }
}