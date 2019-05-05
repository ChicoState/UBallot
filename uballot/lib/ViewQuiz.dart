import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'object.dart';
import 'alterdata.dart';
import 'Widgets/Question.dart';
import 'Widgets/Response.dart';
import 'Models/Quiz.dart';
import 'Services/QuizService.dart';
import 'dart:async';
import 'login.dart';

class ViewQuiz extends StatefulWidget{
  @override
  _ViewQuiz createState()=> _ViewQuiz();

}

class _ViewQuiz extends State<ViewQuiz> {
  String user;
  Map<String, dynamic> classes = new Map();
  List<String>classNames = new List();

  getFirebaseUser() async{
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    setState(() {
      this.user = _user.uid;
      getClasses();
      //print(this.user);
    });

  }

  
  getClasses() async{
  //  if(this.user != null) {
    //setState(() {
      await Firestore.instance.collection(this.user)
          .document("Classes").snapshots().listen((qs) {
        if (qs.exists) {
          for (String key in qs.data.keys) {
            setState(() {
              classNames.add(key.toString());
            });

            print(key.toString());
          }
        }
      });
    //});
    //}
    //print(this.classNames);
    
  }
  
  Future<LoginPage>_logOut() async{
    await FirebaseAuth.instance.signOut().then((_){
      Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) => false);
    });
    return LoginPage();
  }

  @override
  void initState(){
    super.initState();
    getFirebaseUser();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
        title: Text("Choose a Class",),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          FlatButton(onPressed: _logOut, child: IconButton(color: Colors.white,icon: Icon(Icons.exit_to_app), onPressed: ()=> _logOut()),),
        ],
      ),
      body: new Center(
        child: new Container(
          child: new ListView.builder(
              itemCount: classNames.length,
              itemBuilder: (context, index){
                final item = classNames[index];
                return Center(
                  child:Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.yellow[400],
                      onPressed: () {
                        Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (context) => new SelectQuiz(userName: this.user, className: item,)
                            )
                        );
                      },child:Text(item),
                    ),
                    /// route to page pass in quiz name and take quiz.
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class SelectQuiz extends StatefulWidget{
  final String userName;
  final String className;
  SelectQuiz({Key key, this.userName, this.className}) :super(key:key);
  @override
  _SelectQuiz createState()=> _SelectQuiz(this.userName, this.className);

}

class _SelectQuiz extends State<SelectQuiz> {
String userName;
String className;
List <String> score = new List();
List <String> total = new List();
_SelectQuiz(this.userName, this.className);
List<String> quizNames = new List();

getQuizzes() async{
  print(this.userName);
  print(this.className);
  setState(() {
    Firestore.instance.collection(this.userName)
        .document("Classes").snapshots().listen((qs){
      if(qs.exists){
        int index = 0;
        for(String key in qs.data[className]["quiz"].keys){
          setState(() {
            quizNames.add(key.toString());
            score.add("0");
            total.add("0");
            int t = 0;
            int s = 0;
            for(String k in qs.data[className]["quiz"][quizNames[index]].keys) {
              print(qs.data[className]["quiz"][quizNames[index]][k.toUpperCase()]);
              if(qs.data[className]["quiz"][quizNames[index]][k.toUpperCase()]["response"] ==
                  qs.data[className]["quiz"][quizNames[index]][k.toUpperCase()]["correctAnswer"]){
                s++;
              }
              t++;
              print(s.toString()+ " "+t.toString());
            }
            score[index] = s.toString();
            total[index] = t.toString();
            index++;

          });
          print("KEEEEEEEY: "+ key.toString());
        }
      }

    });
  });

  //print(this.quizNames);
}

getColor(score, total){
  if(double.parse(score)/double.parse(total) >= .7){
    return Colors.green;
  }
  return Colors.redAccent;
}

Future<LoginPage>_logOut() async{
  await FirebaseAuth.instance.signOut().then((_){
    Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) => false);
  });
  return LoginPage();
}

@override
void initState(){
  getQuizzes();
  super.initState();
}

@override
Widget build(BuildContext context) {
  print(this.quizNames);
  return Scaffold(
    backgroundColor: Colors.blueGrey[400],
    appBar: AppBar(
      title: Text("Choose a Quiz",),
      centerTitle: true,
      backgroundColor: Colors.blue[900],
      actions: <Widget>[
        FlatButton(onPressed: _logOut, child: IconButton(color: Colors.white,icon: Icon(Icons.exit_to_app), onPressed: ()=> _logOut()),),
      ],
    ),
    body: new Center(
      child: new Container(
        child: new ListView.builder(
            itemCount: quizNames.length,
            itemBuilder: (context, index){
              final item = quizNames[index];
              return Center(
                child:Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    color: getColor(score[index], total[index]),//Colors.yellow[400],
                    onPressed: () {
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (context) => new ViewQuestions(userName: this.userName, className: this.className,  quizName: item,)
                          )
                      );
                    },child:Text(item + " " + score[index] +"/"+ total[index] ),
                  ),
                  /// route to page pass in quiz name and take quiz.
                ),
              );
            }),
      ),
    ),
  );
}
}

class ViewQuestions extends StatefulWidget{
  final String userName;
  final String className;
  final String quizName;
  ViewQuestions({Key key, this.userName, this.className, this.quizName}) :super(key:key);
  @override
  _ViewQuestions createState()=> _ViewQuestions(this.userName, this.className, this.quizName);

}

class _ViewQuestions extends State<ViewQuestions> {
  String userName;
  String className;
  String quizName;
  _ViewQuestions(this.userName, this.className, this.quizName);
  List<Response> questions = new List();
  Response r = new Response();
  List<Map<dynamic, dynamic>> m = new List();

  getQuestions() async {

    Firestore.instance.collection(this.userName)
        .document("Classes").snapshots().listen((qs){
      if(qs.exists){
        int index = 0;
        for(String key in qs.data[className]["quiz"][quizName].keys){
          setState(() {
            m.add(qs.data[className]["quiz"][quizName][key.toString()]);
            r.responseFromJson(new Map<dynamic, dynamic>.from(qs.data[className]["quiz"][quizName][key.toString()]));
            print("question: "+r.toString());
            questions.add(r);
            print("question: "+r.question);
            //print(m[0]["question"].toString());
            index++;
          });

        }
        print("-----QUESTIONS------");
        print(this.questions.toString());
      }
    });

  }

  getColor(item){
    if(item['correctAnswer'] == item['response']){
      return Colors.green;
    }
    return Colors.redAccent;
  }

  Future<LoginPage>_logOut() async{
    await FirebaseAuth.instance.signOut().then((_){
      Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) => false);
    });
    return LoginPage();
  }

  @override
  void initState(){
    getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(this.questions);
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
        title: Text(quizName,),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          FlatButton(onPressed: _logOut, child: IconButton(color: Colors.white,icon: Icon(Icons.exit_to_app), onPressed: ()=> _logOut()),),
        ],
      ),
      body: new Center(
        child: new Container(
          child: new ListView.builder(
              itemCount: m.length,
              itemBuilder: (context, index){
                final item = m[index];
                return Center(
                  child:Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: getColor(item),
                      onPressed: () {
                        Navigator.of(context).push(
                            new MaterialPageRoute(
                                //builder: (context) => new QuizzesFromFirebase(className: item,)
                            )
                        );
                      },child:Text(item['question'].toString()),
                    ),
                    /// route to page pass in quiz name and take quiz.
                  ),
                );
              }),
        ),
      ),
    );
  }

}