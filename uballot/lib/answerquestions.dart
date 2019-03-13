import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'object.dart';
import 'alterdata.dart';
import 'Widgets/Question.dart';
import 'Models/Quiz.dart';
import 'Services/QuizService.dart';
import 'dart:async';


class QuizzesFromFirebase extends StatefulWidget{
  //@override
  //_QuestionsFromFirebase createState() => _QuestionsFromFirebase();
  @override
  _QuizzesFromFirebase createState() => _QuizzesFromFirebase();
}

class _QuizzesFromFirebase extends State<QuizzesFromFirebase> {
  String quizName;
  List<Quiz> quizzes;
  List<String> names = new List();
  CollectionReference collectionReference = Firestore.instance.collection(('Quizzes'));
  QuizService quizService = new QuizService();
  StreamSubscription<QuerySnapshot> quizStream;

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

  @override
  void initState(){
    getQuizzesFromFirebase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
          appBar: AppBar(
            title: Text("Choose a Quiz"),
            centerTitle: true,
          ),
          body: new Center(
            child: new Container(
            child: new ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index){
                final item = names[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(

                      child: Text(item,
                        style: TextStyle(color: Colors.white,
                          fontSize: 20,
                          decorationColor: Colors.green),
                      ),
                      color: Colors.green,
                      //onPressed: null,
                    )

                  ],

                );

              }),

        ),
          ),
        ),
    );
  }
}

//TODO: navigate to questions and display A,B,C,D
/**
class _QuestionsFromFirebase extends State<QuestionsFromFirebase> {
  // final String user;

  // _MyApp({Key key, this.user}) : super (key:key);

  final FirebaseAuth _auth= FirebaseAuth.instance;
  ChangeDatabase quiz=new ChangeDatabase();
  Object please=new Object();
  List<bool> bool_list= [false,false,false,false];
  int counter=1;


/*

  getQuestions() async {
    final DocumentReference postRef = Firestore.instance.document("user/"+userData.uid);
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(postRef);
      if(postSnapshot.exists) {
//        if(postSnapshot!=null) {
        setState(() {
          ss = postSnapshot;
        });
      } else {
        print('no data');
        print(userData.uid);
        changeData();
      }
    });
  }
*/

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'UBallot',
      //probably not needed
      home: WillPopScope(
        onWillPop: () async{
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text('Quiz Question '+counter.toString(),
              style: TextStyle(color: Colors.white),),
          ),
          body:
          Align(
            alignment: Alignment.center,
            child:
            Container(
              height: MediaQuery.of(context).size.height/2,
              child: ListView(

                children: <Widget>[
                  RaisedButton(
                    child: Text('A',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: bool_list[0]?Colors.blue:Colors.green,
                    onPressed: (){
                      setState(()=>bool_list=[true,false,false,false]);
                      please.answer='A';
                      //FirebaseUser user= _auth.currentUser();
                      //please.username=temp.;
                    },
                  ),

                  RaisedButton(
                    child: Text('B',
                      style: TextStyle(color: Colors.white),),
                    color: bool_list[1]?Colors.blue:Colors.green,
                    onPressed: (){
                      setState(()=>bool_list=[false,true,false,false]);
                      please.answer='B';
                      // please.uid=user;
                      //  quiz.updateData('Answers_to_quiz', please.toJson());
                      //  quiz.addData(please.toJson());
                    },
                  ),
                  RaisedButton(
                    child: Text('C',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: bool_list[2]?Colors.blue:Colors.green,
                    onPressed: (){
                      setState(()=>bool_list=[false,false,true,false]);

                      please.answer='C';
                      //please.uid=user;


                      //quiz.do_something(please.uid,please.toJson());
                      //  quiz.updateData('Answers_to_quiz', please.toJson());
                      //  quiz.addData(please.toJson());
                    },
                  ),
                  RaisedButton(
                    child: Text('D',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: bool_list[3]?Colors.blue:Colors.green,
                    onPressed: (){
                      setState(()=>bool_list=[false,false,false,true]);
                      please.answer='D';
                      //please.uid=user;
                    },
                  ),
                  RaisedButton(
                      child: Text('Next Question',
                        style: TextStyle(color: Colors.white),),
                      color: Colors.red,
                      onPressed: () {
                        counter+=1;
                        setState(() {
                        //  please.uid="${widget.user}";
                          please.question_number=counter;
                          quiz.do_something(please.uid,please.toJson());
                          bool_list=[false,false,false,false];
                         // MyApp();
                        });
                        //Navigator.push(context,
                        //  MaterialPageRoute(builder: (context) => new MyApp()));
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
    */