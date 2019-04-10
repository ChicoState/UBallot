import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'object.dart';
import 'alterdata.dart';
import 'Widgets/Question.dart';
import 'Models/Quiz.dart';
import 'Services/QuizService.dart';
import 'dart:async';

class TakeQuiz extends StatefulWidget{
  final String quizName;
  TakeQuiz({Key key, this.quizName}) :super(key:key);
  @override
  _TakeQuiz createState()=> _TakeQuiz(this.quizName);
}

class _TakeQuiz extends State<TakeQuiz> {
  List<Map<String, dynamic>> questions = [];
  Question q = new Question();
  String quizName;
   _TakeQuiz(this.quizName);


  getQuestions(String name) async{
    Firestore.instance.collection('Quizzes').
    document('Class1').snapshots().listen((qs){
      if(qs.exists) {
        //print(qs.data['quiz'][name].map.foreach())
        for(String key in qs.data['quiz'][name].keys) {
          setState(() {
            //print(new Map<dynamic, dynamic>.from(qs.data['quiz'][name][key.toString()]));
            questions.add(q.questionFromJson(new Map<dynamic, dynamic>.from(qs.data['quiz'][name][key.toString()])));
          });
        }
        print(questions.toString());
        //qs.data['quiz'][name].foreach((q) => print(q.toString()));
        //print(qs.data['quiz'][name].map((questionNum).map((i) => q.questionFromJson(i))).toList());
      }
    });
  }
  @override
  void initState(){
    //getQuizzesFromFirebase();
    getQuestions(this.quizName);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('$quizName'), centerTitle: true,),
        body: new Center(
          child: new Container(
            child: new ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index){
                final item = questions[index];
                return Center(
                  child: Text(item.toString()),
                );
              },
          )
          )
        )
      ),
    );

  }
}