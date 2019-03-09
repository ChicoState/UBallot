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
      print(document.data['boolean'].path);
      var stuff= document.data['boolean'].path.split('/');

      setState(() {
        print(stuff[1]);
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


@override
  Widget build(BuildContext context) {
  getQuestions();
  sad();
    return Scaffold(
      appBar: AppBar(title: Text('asdsa'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(ss.data.toString()),
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
    QuestionsFromFirebase(),
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
          canvasColor:  Colors.red,
        ),
            child: BottomNavigationBar(
              currentIndex: currentPage,
              onTap: changePage,
              items: [
              BottomNavigationBarItem(title: Text('sds'),icon: Icon(Icons.account_circle)),
              BottomNavigationBarItem(title: Text('test'),icon: Icon(Icons.image)),
              BottomNavigationBarItem(title: Text('aaaa'),icon: Icon(Icons.image)),
          ],
            ),
        ),
    );
  }
}