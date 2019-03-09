import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

import 'createquiz.dart';
import 'object.dart';
import 'alterdata.dart';
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        '/':(context)=> Home(),
        '/login':(context)=>LoginPage(),
        '/home':(context)=> Home(),
        '/createquiz':(context)=>CreateQuiz(),
      },
    );
  }
}





//void main() => runApp(new MaterialApp(
//    home: new Home()),
//);

class MyApp extends StatefulWidget{
  final String user;
   MyApp({Key key, this.user}) : super (key:key);

  @override

  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
 // final String user;

 // _MyApp({Key key, this.user}) : super (key:key);

  final FirebaseAuth _auth= FirebaseAuth.instance;
  ChangeDatabase quiz=new ChangeDatabase();
  Object please=new Object();
  List<bool> bool_list= [false,false,false,false];
  int counter=1;


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
                      please.uid="${widget.user}";
                      please.question_number=counter;
                      quiz.do_something(please.uid,please.toJson());
                      bool_list=[false,false,false,false];
                      MyApp();
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