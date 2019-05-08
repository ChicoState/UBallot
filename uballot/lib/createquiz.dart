import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Widgets/Question.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewQuizName extends StatefulWidget {
  @override
  _NewQuizName createState() => _NewQuizName();
}



class _NewQuizName extends State<NewQuizName> {
  String quizName;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var _TextEditingController= TextEditingController();

  submitQuizName(){
    final key = _formKey.currentState;
    if(key.validate()){
      key.save();
      try{
        print('here');
        print('quiz name is '+quizName);
      }catch(e){
        print(e.toString() +' error occured');
      }
    } else {
      print('not validated');
    }
  }

  Future<LoginPage>_logOut() async{
    await FirebaseAuth.instance.signOut().then((_){
      Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) => false);
    });
    return LoginPage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Image.asset('assets/UBallots.png',scale: .4,),centerTitle: true,
        actions: <Widget>[
          FlatButton(onPressed: _logOut, child: IconButton(color: Colors.white,icon: Icon(Icons.exit_to_app), onPressed: ()=> _logOut()),),
        ],),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
          children:<Widget>[
          Center(
            child: Container(
              color: Colors.grey,
              child: TextFormField(
                controller: _TextEditingController,
                validator: (val)=>val==''?val:null,
                onSaved: (val)=>quizName=val,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          ),
          RaisedButton(child: Text("Submit", style: TextStyle(color: Colors.white),),color: Colors.black,onPressed: (){
            print('pressed button');
            submitQuizName();
            var route=MaterialPageRoute(builder: (BuildContext context) => CreateQuiz(titlequiz: _TextEditingController.text));
            Navigator.of(context).push(route);
           // Navigator.pushNamed(context,'/createquiz',);
          }),
          ],
    ),
    ),
        ],
      ),
    );
  }
}



class CreateQuiz extends StatefulWidget{
  final String titlequiz;
  CreateQuiz({Key key, this.titlequiz}) :super(key:key);
  @override
  _CreateQuiz createState()=> _CreateQuiz();
}

class _CreateQuiz extends State<CreateQuiz> {
  String nameOfQuiz;

  int questionNumber;
  final Question quizQuestion= new Question();
  int radioVal=-1;
  List<bool> filled= [false,false,false,false,false];
  TextEditingController QUESTION=TextEditingController();
  TextEditingController ANSWER=TextEditingController();
  TextEditingController A= TextEditingController();
  TextEditingController B=TextEditingController();
  TextEditingController C= TextEditingController();
  TextEditingController D=TextEditingController();
  TextEditingController E= TextEditingController();
  TextEditingController FeedBack= TextEditingController();


  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> valueToString=['A','B','C','D','E'];

  @override
  void initState(){
    super.initState();
    questionNumber=1;
  }

  setAnswer(int value){
    setState(() {
      radioVal=value;
      filled.fillRange(0, filled.length,false);
      filled[radioVal]=true;
    });
  }

  saveToFirebase(int q_number){
//    Firestore.instance.collection(this.nameOfQuiz).document(q_number.toString()).setData(quizQuestion.questionToJson());


  Map<String,Map<String,Map<String,Map<String,String>>>> quiz={'quiz':{this.nameOfQuiz:{q_number.toString():quizQuestion.questionToJson()}}};
  Firestore.instance.collection('Quizzes').document('Class1').setData(quiz,merge: true);

//    Firestore.instance.collection('Quizzes').document('Class1').setData(quizQuestion.questionToJson());
  }


  saveQuestion(){
    final formState=_formKey.currentState;
    if(formState.validate()){
      formState.save();
     // quizQuestion.question=questions;
    //  quizQuestion.A=a;
    //  quizQuestion.B=b;
    //  quizQuestion.C=c;
     // quizQuestion.D=d;
     // quizQuestion.E=e;
      quizQuestion.correctAnswer=valueToString[radioVal];
      print(quizQuestion.correctAnswer);

      saveToFirebase(questionNumber);
      setState(() {
        A.clear();B.clear();QUESTION.clear();C.clear();D.clear();E.clear();FeedBack.clear();
        radioVal=-1;
        questionNumber+=1;
        filled.fillRange(0, filled.length,false);
      });
    }
  }

  Future<LoginPage>_logOut() async{
    await FirebaseAuth.instance.signOut().then((_){
      Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) => false);
    });
    return LoginPage();
  }

  @override
  Widget build(BuildContext context) {
//    radioVal=-
    setState(() {
      nameOfQuiz='${widget.titlequiz}';
    });
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text(nameOfQuiz+" question# "+questionNumber.toString(),),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          FlatButton(onPressed: _logOut, child: IconButton(color: Colors.white,icon: Icon(Icons.exit_to_app), onPressed: ()=> _logOut()),),
        ],),
      backgroundColor: Colors.blueGrey[400],
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
          children: <Widget>[
            TextFormField(decoration: InputDecoration(labelText: "question"),
              controller: QUESTION,
              onSaved: (val)=>quizQuestion.question=val,
              validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "A",fillColor: Colors.green,filled: filled[0]),
              controller: A,
              onSaved: (val)=>quizQuestion.A=val,
              validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "B",fillColor: Colors.yellow,filled: filled[1]),
              controller: B,
              onSaved: (val)=>quizQuestion.B=val,
              validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "C",fillColor: Colors.blue,filled: filled[2]),
              controller: C,
              onSaved: (val)=>quizQuestion.C=val,
             // validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "D",fillColor: Colors.pink,filled: filled[3]),
              controller: D,
              onSaved: (val)=>quizQuestion.D=val,
              //validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "E",fillColor: Colors.orange,filled: filled[4]),
              controller: E,
              onSaved: (val)=>quizQuestion.E=val,
              //validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "FeedBack"),
              controller: FeedBack,
              onSaved: (val)=>quizQuestion.FeedBack=val,
              //validator: (val)=>val==''?val:null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Column(
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: radioVal,
                      onChanged: setAnswer,
                      activeColor: Colors.green,
                    ),
                    Text('A'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Radio(
                      onChanged: setAnswer,
                      groupValue: radioVal,
                      value: 1,
                      activeColor: Colors.yellow,
                    ),
                    Text('B'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Radio(
                      onChanged: setAnswer,
                      groupValue: radioVal,
                      value: 2,
                      activeColor: Colors.blue,
                    ),
                    Text('C'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Radio(
                      onChanged: setAnswer,
                      groupValue: radioVal,
                      value: 3,
                      activeColor: Colors.pink,
                    ),
                    Text('D'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Radio(
                      onChanged: setAnswer,
                      groupValue: radioVal,
                      value: 4,
                      activeColor: Colors.orange,
                    ),
                    Text('E'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    //Container(width: 80.0,child: RaisedButton(child: Text('NEXT'),onPressed: null),),
                    Container(width: 80.0,child: radioVal==-1?Text('complete the question to add a new question'):RaisedButton(child: Text('NEXT'),onPressed: saveQuestion),)
                  ],
                ),
              ]
            ),
          ],
        ),
      ),
      ),
    );
  }
}
