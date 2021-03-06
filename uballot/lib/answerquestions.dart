import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Models/Question.dart';
import 'dart:async';
import 'takequiz.dart';
import 'login.dart';


class ClassesFromFirebase extends StatefulWidget{
  @override
  _ClassesFromFirebase createState() => _ClassesFromFirebase();
}

class _ClassesFromFirebase extends State<ClassesFromFirebase> {
 QuerySnapshot getclassnames;
  List<String> classes = [];

  showClasses() async {
   getclassnames = await Firestore.instance.collection('Quizzes').getDocuments();
   getclassnames.documents.forEach((d){
     setState(() {
       classes.add(d.documentID);
     });

   });

  }




  Future<LoginPage>_logOut() async{
    await FirebaseAuth.instance.signOut().then((_){
      Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) => false);
    });
    return LoginPage();
  }

  @override
  void initState(){
    //getQuizzesFromFirebase();
    showClasses();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/UBallots.png',scale: .4,),centerTitle: true,
        actions: <Widget>[
          FlatButton(onPressed: _logOut, child: IconButton(color: Colors.white,icon: Icon(Icons.exit_to_app), onPressed: ()=> _logOut()),),
        ],
      ),
      body: new Center(
        child: new Container(
          child: new ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index){
                final item = classes[index];
                return Center(
                  child:Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (context) => new QuizzesFromFirebase(className: item,)
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

class QuizzesFromFirebase extends StatefulWidget{
  //@override
  //_QuestionsFromFirebase createState() => _QuestionsFromFirebase();
  final String className;
  QuizzesFromFirebase({Key key, this.className}) :super(key:key);
  @override
  _QuizzesFromFirebase createState() => _QuizzesFromFirebase(this.className);
}

class _QuizzesFromFirebase extends State<QuizzesFromFirebase> {
  String quizName;
  String className;
  _QuizzesFromFirebase(this.className);
  List<Map<String, Map<String, Map<String,String>>>> names = new List();
  CollectionReference collectionReference = Firestore.instance.collection(('Quizzes'));
  StreamSubscription<QuerySnapshot> quizStream;
  List<String> quizList= [] ;
  List<Map<String, dynamic>> questions = [];
  Question q = new Question();


  StreamSubscription<DocumentSnapshot> getnames;

  showClassQuizzes() async {
    getnames = Firestore.instance.collection('Quizzes').
    document(this.className).snapshots().listen((qs){
      if(qs.exists) {
        for(String key in qs.data['quiz'].keys) {
          setState(() {
            quizList.add(key.toString());
          });
        }
      }
    });
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
        print(questions.length);
      }
    });
  }



  Future<LoginPage>_logOut() async{
    await FirebaseAuth.instance.signOut().then((_){
      Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) => false);
    });
    return LoginPage();
  }

  @override
  void initState(){
    //getQuizzesFromFirebase();
    showClassQuizzes();
    getQuestions('test2');

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: AppBar(title: Image.asset('assets/UBallots.png',scale: .4,),centerTitle: true,
            actions: <Widget>[
              FlatButton(onPressed: _logOut, child: IconButton(color: Colors.white,icon: Icon(Icons.exit_to_app), onPressed: ()=> _logOut()),),
            ],
          ),
          body: new Center(
            child: new Container(
            child: new ListView.builder(
              itemCount: quizList.length,
              itemBuilder: (context, index){
                final item = quizList[index];
                return Center(
                  child:Container(
                    width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    onPressed: () {
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (context) => new TakeQuiz(quizName: item, className: this.className)
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



class QuestionsFromFirebase extends StatefulWidget{
  final String titleOfQuiz;
  final String className;
  QuestionsFromFirebase({Key key,this.titleOfQuiz, this.className}): super(key:key);
  @override
  _QuestionsFromFirebase createState() => _QuestionsFromFirebase();
}

class _QuestionsFromFirebase extends State<QuestionsFromFirebase> {


  String quizName;
  String className;
  List<String> names = new List();
  CollectionReference collectionReference = Firestore.instance.collection(('Quizzes'));
  StreamSubscription<QuerySnapshot> quizStream;
  DocumentSnapshot ds;
  String name;
  StreamSubscription<DocumentSnapshot> getnames;
  String sample;


  @override
  void initState(){
    getQuizzesFromFirebase();
    showClassQuizzes();
    super.initState();
  }

  showClassQuizzes() async {
    getnames = Firestore.instance.collection('Quizzes').
    document(this.className).snapshots().listen((qs){
      if(qs.exists) {
       // print('qs is'+qs.data['quiz']);
        for(String quiz in qs['quiz']) {
          print(quiz);
        }
        setState(() {
          sample=qs.data['quiz'];
        });
      }
    });
  }


  getQuizzesFromFirebase() async {
    DocumentReference document=Firestore.instance.collection('Quizzes').document('Class1');
    document.get().then((doc){
      if (doc.exists){
        print('document exists');
        print(doc.data['className'].toString());
        setState(() {
          name=doc.data['className'].toString();
          print(doc.data['quiz']['Quiz1']['question1']['question']['a']);
        });
      }
    });


  }




  @override
  Widget build(BuildContext context) {
    showClassQuizzes();
    print(sample);

    return Scaffold(
      appBar: AppBar(title: Text('${widget.titleOfQuiz}'),),
      backgroundColor: Colors.blue,
      body: Text(sample),
    );
  }
}
