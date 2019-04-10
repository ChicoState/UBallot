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
  List<bool> bool_list= [false,false,false,false,false];
  bool selected;
  int questionNumber;



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
    selected=false;
    questionNumber=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(title: Text('$quizName'), centerTitle: true,),
        body: Center(
          child:Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    child:Text(questions[questionNumber]['question'].toString(),style: TextStyle(fontSize: 20),
                    ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/5,
                  alignment: Alignment.center,
                ),

              ],
            ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            child:
          Column(
            children: <Widget>[
              Container(child:RaisedButton(color:bool_list[0]?Colors.deepPurple:Colors.cyan,child:
              Text(questions[questionNumber]['A'].toString()),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[true,false,false,false,false];
                });
              },
              ),
              width: MediaQuery.of(context).size.width,),
              Container(child:RaisedButton(color:bool_list[1]?Colors.deepPurple:Colors.cyan,child:Text(questions[0]['B'].toString()),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[false,true,false,false,false];

                });
              },),width: MediaQuery.of(context).size.width,),
              (questions[questionNumber]['C']!="")?Container(child:RaisedButton(color:bool_list[2]?Colors.deepPurple:Colors.cyan,child:Text(questions[0]['C'].toString()),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[false,false,true,false,false];
                });
              },),
              width: MediaQuery.of(context).size.width,):Container(),
              (questions[questionNumber]['D']!="")?Container(child:RaisedButton(color:bool_list[3]?Colors.deepPurple:Colors.cyan,child:Text(questions[0]['C'].toString()),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[false,false,false,true,false];
                });
              },),width: MediaQuery.of(context).size.width,):Container(),
              (questions[questionNumber]['E']!="")?Container(width: MediaQuery.of(context).size.width,child:RaisedButton(color:bool_list[4]?Colors.deepPurple:Colors.cyan,child:Text(questions[0]['C'].toString()),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[false,false,false,false,true];
                });
              },)):Container(),

              selected?Center(child:
              RaisedButton(onPressed: (){
                setState(() {
                  selected=false;
                  if(questions.length<=1+questionNumber){
                    Navigator.of(context).pushNamedAndRemoveUntil('/',(Route<dynamic> route) => false);
                  } else {
                    questionNumber++;
                  }
                });
              },child: Text('Next'),),):Container(),

            ],
          ),
    ),
          ],
        ),
        ),
      ),
    );

  }
}