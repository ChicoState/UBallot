import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Widgets/Question.dart';
import 'Widgets/Response.dart';
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
  String uid;
  Response userResponse = new Response();
  Map<String, dynamic> map = new Map();
  String user;

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
        for(String key in qs.data['quiz'][name].keys) {
          setState(() {
            questions.add(q.questionFromJson(new Map<dynamic, dynamic>.from(qs.data['quiz'][name][key.toString()])));
          });
        }
        print(questions.toString());
      }
    });
  }
  storeResponse(quizNumber, uResponse){
    Map<String, dynamic> m = new Map();
    m = {className: {
      'quiz':{
        quizName :{

        }
      }
    }
    };

    Firestore.instance.collection(this.user)
        .document('Classes').snapshots().listen((qs){
          if(qs.exists) {
            for(String key in qs.data[className]['quiz'].keys){
              m[className]['quiz'][key.toString()] = qs.data[className]['quiz'][key.toString()];
            }
            if(qs.data[className]['quiz'][quizName] != null){
              for(String key in qs.data[className]['quiz'][quizName].keys){
                this.map[key.toString()] = qs.data[className]['quiz'][quizName][key.toString()];
              }
              print(this.map);
            }
          }
    });

    m[className]['quiz'][quizName] = this.map;
    print(m);

    final Firestore store = Firestore.instance;
    Firestore.instance.runTransaction((transaction) async {
      store.collection(this.user).document('Classes')
      .setData(m)
          .catchError((e){
            print(e);
      });
    });

  }
  getFirebaseUser() async{
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    setState(() {
      this.user = _user.uid;
      print(this.user);
    });
  }
  @override
  void initState(){
    //getQuizzesFromFirebase();
    getQuestions(this.quizName);
    getFirebaseUser();
    selected=false;
    questionNumber=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Colors.blueGrey[400],
        appBar: AppBar(title: Text('$quizName',style: TextStyle(color: Colors.white),), centerTitle: true,backgroundColor: Colors.blue,
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
                  userResponse.response = 'A';
                  print(userResponse.toString());
                });
              },
              ),
              width: MediaQuery.of(context).size.width,),
              Container(child:RaisedButton(color:bool_list[1]?Colors.black:Colors.white,child:Text(questions[questionNumber]['B'].toString(),style: TextStyle(color: bool_list[1]?Colors.white:Colors.black),),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[false,true,false,false,false];
                  userResponse.response = 'B';

                });
              },),width: MediaQuery.of(context).size.width,),
              (questions[questionNumber]['C']!='')?Container(child:RaisedButton(color:bool_list[2]?Colors.black:Colors.white,child:Text(questions[questionNumber]['C'].toString(),style: TextStyle(color: bool_list[2]?Colors.white:Colors.black),),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[false,false,true,false,false];
                  userResponse.response = 'C';
                });
              },),
              width: MediaQuery.of(context).size.width,):Container(),
    (questions[questionNumber]['D']!='')?Container(child:RaisedButton(color:bool_list[3]?Colors.black:Colors.white,child:Text(questions[questionNumber]['D'].toString(),style: TextStyle(color: bool_list[3]?Colors.white:Colors.black),),onPressed: (){
       setState(() {
                  selected=true;
                  bool_list=[false,false,false,true,false];
                  userResponse.response = 'D';
                });
              },),width: MediaQuery.of(context).size.width,):Container(),
              (questions[questionNumber]['E']!='')?Container(child:RaisedButton(color:bool_list[4]?Colors.black:Colors.white,child:Text(questions[questionNumber]['E'].toString(),style: TextStyle(color: bool_list[4]?Colors.white:Colors.black),),onPressed: (){
                setState(() {
                  selected=true;
                  bool_list=[false,false,false,false,true];
                  userResponse.response = 'E';
                });
              },)):Container(),

              selected?Center(child:
              RaisedButton(onPressed: (){
                setState(() {
                  bool_list.fillRange(0, bool_list.length,false);
                  selected=false;
                  userResponse.question = questions[questionNumber]['question'];
                  userResponse.correctAnswer = questions[questionNumber]['correctAnswer'];
                  userResponse.FeedBack = (questions[questionNumber]['FeedBack']=='')? '': questions[questionNumber]['FeedBack'];
                  userResponse.A = (questions[questionNumber]['A']=='')? '' : questions[questionNumber]['A'];
                  userResponse.B = (questions[questionNumber]['B']=='')? '' : questions[questionNumber]['B'];
                  userResponse.C = (questions[questionNumber]['C']=='')? '' : questions[questionNumber]['C'];
                  userResponse.D = (questions[questionNumber]['D']=='')? '' : questions[questionNumber]['D'];
                  userResponse.E = (questions[questionNumber]['E']=='')? '' : questions[questionNumber]['E'];
                  //userResponse.quizQuestion = questionNumber.toString();
                  //userResponse.className = this.className;
                  //userResponse.quizName = this.quizName;
                  map[questionNumber.toString()] = userResponse.responseToJson();
                  if(questions.length<=1+questionNumber){
                    storeResponse(questionNumber,map);
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