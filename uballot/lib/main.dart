import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'object.dart';
import 'alterdata.dart';
import 'login.dart';
//import 'package:flutter/services.dart';
//import 'dart:io';


/*
https://tphangout.com/flutter-firestore-crud-updating-deleting-data/
https://flutter.io/docs/catalog/samples/expansion-tile-sample
https://stackoverflow.com/questions/49869873/flutter-update-widgets-on-resume
 */

void main() => runApp(new MaterialApp(
    home: new LoginPage()),
);

class MyApp extends StatelessWidget {
  final String user;

  MyApp({Key key, this.user}) : super (key:key);

  final FirebaseAuth _auth= FirebaseAuth.instance;
  ChangeDatabase quiz=new ChangeDatabase();
  Object please=new Object();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UBallot',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Question'),
        ),
        body:
          Center(
            child: ListView(
              children: <Widget>[
                RaisedButton(
                  child: Text('A'),
                  onPressed: (){
                    please.answer='A';
                    please.username=user;
                    //FirebaseUser user= _auth.currentUser();
                    //please.username=temp.;
                    quiz.addData(please.toJson());
                  },
                ),
                RaisedButton(
                  child: Text('B'),
                  onPressed: (){
                    please.answer='B';
                    quiz.updateData('Answers_to_quiz', please.toJson());
                  //  quiz.addData(please.toJson());
                  },
                ),
                RaisedButton(
                  child: Text('C'),
                  onPressed: (){
                    please.answer='C';
                    quiz.updateData('Answers_to_quiz', please.toJson());
                  //  quiz.addData(please.toJson());
                  },
                ),
                RaisedButton(
                  child: Text('D'),
                  onPressed: (){
                    please.answer='D';
                    quiz.addData(please.toJson());
                  },
                ),
              ],
            ),
        ),
      ),
    );
  }
}

/*
handleAppLifecycleState() {
  AppLifecycleState _lastLifecyleState;
  SystemChannels.lifecycle.setMessageHandler((msg) {

    print('SystemChannels> $msg');

    switch (msg) {
      case "AppLifecycleState.paused":
        _lastLifecyleState = AppLifecycleState.paused;
        break;
      case "AppLifecycleState.inactive":
        _lastLifecyleState = AppLifecycleState.inactive;
        break;
      case "AppLifecycleState.resumed":
        _lastLifecyleState = AppLifecycleState.resumed;
        break;
      case "AppLifecycleState.suspending":
        _lastLifecyleState = AppLifecycleState.suspending;
        break;
      default:
    }
  });
}

*/