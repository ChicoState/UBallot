import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'main.dart';

/*
https://medium.com/@anilcan/forms-in-flutter-6e1364eafdb5
https://www.youtube.com/watch?v=13-jNF984C0

*/

class _LoginData{
  String email='';
  String password='';
}

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  _LoginData credentials = new _LoginData();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final FirebaseAuth auth= FirebaseAuth.instance;

  Future<void> SignIn() async{
    final formState=_formKey.currentState;

    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: credentials.email, password: credentials.password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> new MyApp()));
      } catch(e){
        print(e.message);
      }
    }
  }

  Future<FirebaseUser> validateUser(_LoginData user) async{
    final FirebaseUser checkUser = await auth.signInWithEmailAndPassword(
        email: null, password: null);
    assert(checkUser!=null);
    assert(await checkUser.getIdToken()!=null);
    final FirebaseUser returnedUser = await auth.currentUser();
    assert(checkUser.uid == returnedUser.uid);
    return returnedUser;
  }



  @override
  Widget build(BuildContext context) {
    final Size screenSize=MediaQuery.of(context).size;


    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Container(
        width: screenSize.width,
        padding: new EdgeInsets.all(20.0),
        child: new Form(
          key: this._formKey,
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "email"
                ),
                onSaved: (val)=> credentials.email=val,
                validator: (val)=>val==''?val:null,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                    labelText: "password",
                ),
                onSaved: (val)=> credentials.password=val,
                validator: (val)=>val==''?val:null,
              ),
              new Container(
                width: screenSize.width,
                child: RaisedButton(
                    child: new Text(
                      'log in', style: new TextStyle(
                      color: Colors.white
                    ),
                    ),
                    onPressed: SignIn),
              ),
             ],
          ),

          ),
        ),
      );
  }
}

