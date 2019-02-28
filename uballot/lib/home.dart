import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:async/async.dart';
import 'answerquestions.dart';
import 'login.dart';
import 'createquiz.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  FirebaseUser user;
  int currentPage=0;
  DocumentSnapshot ss;

  final List<Widget> renderedWidget =[
    CreateQuiz(),
    QuestionsFromFirebase(),
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
          canvasColor:  Colors.red,
        ),
            child: BottomNavigationBar(
              currentIndex: currentPage,
              onTap: changePage,
              items: [
              BottomNavigationBarItem(title: Text('sds'),icon: Icon(Icons.account_circle)),
              BottomNavigationBarItem(title: Text('aaaa'),icon: Icon(Icons.image)),
          ],
            ),
        ),
    );
  }
}