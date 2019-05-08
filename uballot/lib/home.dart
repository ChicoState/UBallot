import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ViewQuiz.dart';
import 'answerquestions.dart';
import 'createquiz.dart';
import 'login.dart';

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
    ClassesFromFirebase(),
    ViewQuiz(),
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
          canvasColor:  Colors.blue,
          textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white))
        ),
            child: BottomNavigationBar(
              fixedColor: Colors.yellow[400],
              currentIndex: currentPage,
              onTap: changePage,
              items: [
              BottomNavigationBarItem(title: Text('Create Quiz'),icon: Icon(Icons.account_circle)),
              BottomNavigationBarItem(title: Text('Take Quiz'),icon: Icon(Icons.image)),
              BottomNavigationBarItem(title: Text('View Quiz'),icon: Icon(Icons.image)),
          ],
            ),
        ),
    );
  }
}