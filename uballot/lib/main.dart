import 'package:flutter/material.dart';
import 'createquiz.dart';
import 'home.dart';
import 'login.dart';


void main() {
  runApp(UBallot());
}

class UBallot extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        '/':(context)=> Home(),
        '/login':(context)=>LoginPage(),
        '/home':(context)=> Home(),
        '/createquiz':(context)=>CreateQuiz(),
      },
    );
  }
