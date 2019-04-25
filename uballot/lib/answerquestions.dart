import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'object.dart';
import 'alterdata.dart';
import 'Widgets/Question.dart';
import 'Models/Quiz.dart';
import 'Services/QuizService.dart';
import 'dart:async';
import 'takequiz.dart';
import 'login.dart';


class ClassesFromFirebase extends StatefulWidget{
  //@override
  //_QuestionsFromFirebase createState() => _QuestionsFromFirebase();
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

    //print(getclassnames.documents.toString());
    //list = templist.map((DocumentSnapshot docSnapshot){
    //  return docSnapshot.data;
    //}).toList();
    //classes = List<String>.from(getclassnames.documents);

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
              itemCount: classes.length,
              itemBuilder: (context, index){
                final item = classes[index];
                return Center(
                  child:Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.yellow[400],
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
/*
class _ClassesFromFirebase extends State<ClassesFromFirebase>{
  List<String> classes;

  showClasses() async{
    getnames = Firestore.instance.collection('Quizzes').
  }
  //_QuizzesFromFirebase createState() => _QuizzesFromFirebase();
}
*/
class _QuizzesFromFirebase extends State<QuizzesFromFirebase> {
  String quizName;
  List<Quiz> quizzes;
  String className;
  _QuizzesFromFirebase(this.className);
  List<Map<String, Map<String, Map<String,String>>>> names = new List();
  CollectionReference collectionReference = Firestore.instance.collection(('Quizzes'));
  QuizService quizService = new QuizService();
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

/*
  getQuizzesFromFirebase() async {
    quizzes = new List();
    quizStream = quizService.getQuiz().listen((QuerySnapshot qs){
      final List<Quiz> q = qs.documents.map((docSnap) =>
        Quiz.fromMap(docSnap.data)).toList();

      setState(() {
        this.quizzes = q;
        this.names = this.quizzes[0].quizzes;
        print("----------------");
        print(this.names.toString());
      });
      });
  }
*/
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
        print(questions.length);
        //qs.data['quiz'][name].foreach((q) => print(q.toString()));
        //print(qs.data['quiz'][name].map((questionNum).map((i) => q.questionFromJson(i))).toList());
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
              itemCount: quizList.length,
              itemBuilder: (context, index){
                final item = quizList[index];
                return Center(
                  child:Container(
                    width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    color: Colors.yellow[400],
                    onPressed: () {
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (context) => new TakeQuiz(quizName: item,)
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
  QuestionsFromFirebase({Key key,this.titleOfQuiz}): super(key:key);
  @override
  _QuestionsFromFirebase createState() => _QuestionsFromFirebase();
}

class _QuestionsFromFirebase extends State<QuestionsFromFirebase> {


  String quizName;
  List<Quiz> quizzes;
  List<String> names = new List();
  CollectionReference collectionReference = Firestore.instance.collection(('Quizzes'));
  QuizService quizService = new QuizService();
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
    document('Class1').snapshots().listen((qs){
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
    quizzes = new List();
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
      body: Text(sample),
    );
  }
}