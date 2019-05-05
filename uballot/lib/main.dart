import 'package:flutter/material.dart';
import 'createquiz.dart';
import 'home.dart';
import 'login.dart';
//import 'package:flutter/services.dart';
//import 'dart:io';


/*
https://tphangout.com/flutter-firestore-crud-updating-deleting-data/
https://flutter.io/docs/catalog/samples/expansion-tile-sample
https://stackoverflow.com/questions/49869873/flutter-update-widgets-on-resume
https://stackoverflow.com/questions/50863681/flutter-how-do-i-toggle-the-color-of-a-raisedbutton-upon-click
 */

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