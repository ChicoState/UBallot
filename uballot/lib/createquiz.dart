import 'package:flutter/material.dart';
import 'Widgets/Question.dart';

class CreateQuiz extends StatefulWidget{
  @override
  _CreateQuiz createState()=> _CreateQuiz();
}

class _CreateQuiz extends State<CreateQuiz> {
  final Question quizQuestion= new Question();
  int radioVal=-1;
  List<bool> filled= [false,false,false,false,false];
  TextEditingController questionCont= TextEditingController();
  TextEditingController ACont= TextEditingController();
//  TextEditingController questionCont= TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> valueToString=['A','B','C','D','E'];

  setAnswer(int value){
    setState(() {
      radioVal=value;
      filled.fillRange(0, filled.length,false);
      filled[radioVal]=true;
    });
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
   //   quizQuestion.correctAnswer=valueToString[radioVal];
     // print(quizQuestion.correctAnswer);
    }
  }

  @override
  Widget build(BuildContext context) {
//    radioVal=-1;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('CREATE A QUIZ'),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
          children: <Widget>[
            TextFormField(decoration: InputDecoration(labelText: "question"),
              onSaved: (val)=>quizQuestion.question=val,
              validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "A",fillColor: Colors.green,filled: filled[0]),
              onSaved: (val)=>quizQuestion.A=val,
              validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "B",fillColor: Colors.yellow,filled: filled[1]),
              onSaved: (val)=>quizQuestion.B=val,
              validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "C",fillColor: Colors.blue,filled: filled[2]),
              onSaved: (val)=>quizQuestion.C=val,
              validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "D",fillColor: Colors.pink,filled: filled[3]),
              onSaved: (val)=>quizQuestion.D=val,
              validator: (val)=>val==''?val:null,
            ),
            TextFormField(decoration: InputDecoration(labelText: "E",fillColor: Colors.orange,filled: filled[4]),
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