import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Widgets/Question.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('Name for quiz'),),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
          children:<Widget>[
          Center(
            child: Container(
              color: Colors.cyan,
              child: TextFormField(
                controller: _TextEditingController,
                validator: (val)=>val==''?val:null,
                onSaved: (val)=>quizName=val,
                style: TextStyle(color: Colors.white),
            ),
          ),
          ),
          RaisedButton(child: Text("Submit", style: TextStyle(color: Colors.white),),color: Colors.red,onPressed: (){
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
  TextEditingController A= TextEditingController();
  TextEditingController B=TextEditingController();
  TextEditingController C= TextEditingController();
  TextEditingController D=TextEditingController();
  TextEditingController E= TextEditingController();


  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> valueToString=['A','B','C','D','E'];

  @override
  void initState(){
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
    Firestore.instance.collection(this.nameOfQuiz).document(q_number.toString()).setData(quizQuestion.questionToJson());
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
        questionNumber+=1;
        //A.clear();

      });
    }
  }

  @override
  Widget build(BuildContext context) {
//    radioVal=-
    setState(() {
      nameOfQuiz='${widget.titlequiz}';
    });
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text(nameOfQuiz+" question# "+questionNumber.toString())),
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
              validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "D",fillColor: Colors.pink,filled: filled[3]),
              controller: D,
              onSaved: (val)=>quizQuestion.D=val,
              validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "E",fillColor: Colors.orange,filled: filled[4]),
              controller: E,
              onSaved: (val)=>quizQuestion.E=val,
              validator: (val)=>val==''?val:null,
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
                    Container(width: 80.0,child: RaisedButton(child: Text('NEXT'),onPressed: null),),
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