import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'object.dart';
import 'alterdata.dart';
import 'Widgets/Question.dart';
import 'Models/Quiz.dart';
import 'Services/QuizService.dart';
import 'dart:async';
import 'login.dart';

class TakeQuiz extends StatefulWidget{
  final String quizName;
  final String className;
  TakeQuiz({Key key, this.quizName, this.className}) :super(key:key);
  @override
  _TakeQuiz createState()=> _TakeQuiz(this.quizName, this.className);
}

class _TakeQuiz extends State<TakeQuiz> {
  List<Map<String, dynamic>> questions = [];
  Question q = new Question();
  String quizName;
  String className;
   _TakeQuiz(this.quizName, this.className);
  List<bool> bool_list= [false,false,false,false,false];
  bool selected;
  int questionNumber;

  Future<LoginPage>_logOut() async{
    await FirebaseAuth.instance.signOut().then((_){
      Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) => false);
    });
    return LoginPage();
  }


  getQuestions(String name) async{
    Firestore.instance.collection('Quizzes').
    document(this.className).snapshots().listen((qs){
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
      return Scaffold(
        backgroundColor: Colors.blueGrey[400],
        appBar: AppBar(title: Text('$quizName',style: TextStyle(color: Colors.white),), centerTitle: true,backgroundColor: Colors.blue[900],
        actions: <Widget>[
          FlatButton(onPressed: _logOut, child: IconButton(color: Colors.white,icon: Icon(Icons.exit_to_app), onPressed: ()=> _logOut()),),
        ],
        ),
        body: Center(
          child:Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    child:Text(questions[questionNumber]['question'].toString(),style: TextStyle(fontSize: 30,color: Colors.white),
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
              Container(child:RaisedButton(color:bool_list[0]?Colors.black:Colors.white,child:
              Text(questions[questionNumber]['A'].toString(),style: TextStyle(color: bool_list[0]?Colors.white:Colors.black),),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[true,false,false,false,false];
                });
              },
              ),
              width: MediaQuery.of(context).size.width,),
              Container(child:RaisedButton(color:bool_list[1]?Colors.black:Colors.white,child:Text(questions[questionNumber]['B'].toString(),style: TextStyle(color: bool_list[1]?Colors.white:Colors.black),),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[false,true,false,false,false];

                });
              },),width: MediaQuery.of(context).size.width,),
              (questions[questionNumber]['C']!="")?Container(child:RaisedButton(color:bool_list[2]?Colors.black:Colors.white,child:Text(questions[questionNumber]['C'].toString(),style: TextStyle(color: bool_list[2]?Colors.white:Colors.black),),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[false,false,true,false,false];
                });
              },),
              width: MediaQuery.of(context).size.width,):Container(),
    (questions[questionNumber]['D']!="")?Container(child:RaisedButton(color:bool_list[3]?Colors.black:Colors.white,child:Text(questions[questionNumber]['D'].toString(),style: TextStyle(color: bool_list[3]?Colors.white:Colors.black),),onPressed: (){
       setState(() {
                  selected=true;
                  bool_list=[false,false,false,true,false];
                });
              },),width: MediaQuery.of(context).size.width,):Container(),
              (questions[questionNumber]['E']!="")?Container(child:RaisedButton(color:bool_list[4]?Colors.black:Colors.white,child:Text(questions[questionNumber]['E'].toString(),style: TextStyle(color: bool_list[4]?Colors.white:Colors.black),),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[false,false,false,false,true];
                });
              },)):Container(),

              selected?Center(child:
              RaisedButton(onPressed: (){
                setState(() {
                  bool_list.fillRange(0, bool_list.length,false);
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
    );

  }
}