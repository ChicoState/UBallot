import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:async/async.dart';
import 'answerquestions.dart';
import 'login.dart';
import 'createquiz.dart';

class test extends StatefulWidget {
  @override
  _test createState() => _test();
}

class _test extends State<test> {
  FirebaseUser user;
  DocumentSnapshot ss;
  DocumentSnapshot wow;
  DocumentSnapshot teach;
  void initState(){
    getFirebase();
    super.initState();
  }

  getFirebase() async{
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = _user;
    });
  }

sad() async {
  Firestore.instance.collection('Classes').snapshots().listen((
      data) {
    data.documents.forEach((document) {
    //  print(document.data['boolean'].path);
      var stuff= document.data['boolean'].path.split('/');

      setState(() {
     //   print(stuff[1]);
      });
    });
  });
}




  getQuestions() async  {
    DocumentSnapshot _ss = await Firestore.instance.collection('Classes').document('oops').get();
    setState(() {
      ss=_ss;
    });
  }

  getQuestionss() async  {
    DocumentSnapshot _ss = await Firestore.instance.collection('Classes').document('oops').get();
      //var path = _ss.data['boolean'].toString().split('/');
      var path = _ss.data['boolean'].path.toString().split('/');
if(_ss!=null) {
  var temp = await Firestore.instance.collection(path[0]).document(path[1]).get();
  print(temp);
  if(temp!=null) {
    setState(() {
      teach = temp;
    });
  }
}
      //ss=_ss;
  }


  @override
  Widget build(BuildContext context) {
 // getQuestions();
  getQuestionss();
  sad();
    return Scaffold(
      appBar: AppBar(title: Text('asdsa'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(teach.data[0]),
          //Text(ss.data['boolean'].toString()),
        ],
      ),
    );
  }
}


class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {


  FirebaseUser user;
  int currentPage=0;
  DocumentSnapshot ss;

  final List<Widget> renderedWidget =[
    NewQuizName(),
    //CreateQuiz(),
    QuizzesFromFirebase(),
    test(),
  ];

  changePage(int index){
    setState(() {
      currentPage=index;
    });
  }


  getFirebase() async{
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
      setState(() {
        user = _user;
      });
  }

  @override
  void initState() {
    getFirebase();
    super.initState();
  }

  getQuestions() async  {
    DocumentSnapshot _ss = await Firestore.instance.collection('Classes').document('oops').get();
    setState(() {
      ss=_ss;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(user==null){
      return Scaffold(
        body: Container(
          child: LoginPage(),
        ),
      );
    }
   // getQuestions();
    return Scaffold(
      body: renderedWidget[currentPage],
      bottomNavigationBar:
        Theme(data: Theme.of(context).copyWith(
          canvasColor:  Colors.blue[900],
          textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white))
        ),
            child: BottomNavigationBar(
              fixedColor: Colors.yellow[400],
              currentIndex: currentPage,
              onTap: changePage,
              items: [
              BottomNavigationBarItem(title: Text('Create Quiz'),icon: Icon(Icons.account_circle)),
              BottomNavigationBarItem(title: Text('Display Quiz'),icon: Icon(Icons.image)),
              BottomNavigationBarItem(title: Text('take quiz'),icon: Icon(Icons.image)),
          ],
            ),
        ),
    );
  }
}