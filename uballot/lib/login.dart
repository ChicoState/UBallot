import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'main.dart';

/*
https://medium.com/@anilcan/forms-in-flutter-6e1364eafdb5
https://www.youtube.com/watch?v=13-jNF984C0
https://stackoverflow.com/questions/50881467/example-of-firebase-auth-with-email-and-password-on-flutter
*/

class _LoginData{
  String email='';
  String password='';
}

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage>{

  _LoginData credentials = new _LoginData();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final FirebaseAuth auth= FirebaseAuth.instance;

  FormType _formType = FormType.login;

  Future<void> signIn() async{
    final formState=_formKey.currentState;

    if(formState.validate()){
      formState.save();
      try{
        if (_formType == FormType.login) {
          FirebaseUser user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: credentials.email, password: credentials.password);
          //validateUser(credentials);
          assert(user != null);
          assert(await user.getIdToken() != null);
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=> new MyApp()));
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => new MyApp(user: user.uid)));
        } else {
          FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: credentials.email, password: credentials.password);
          //validateUser(credentials);
          assert(user != null);
          assert(await user.getIdToken() != null);
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=> new MyApp()));
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => new MyApp(user: user.uid)));
        }
      } catch(e){
        print(e.message);
        //  return;
        //FIX EXIT HERE LATER!! OR FAIL LOGIN
      }
    }
  }

  Future<FirebaseUser> validateUser(_LoginData user) async{
    final FirebaseUser checkUser = await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
    assert(checkUser!=null);
    assert(await checkUser.getIdToken()!=null);
    final FirebaseUser returnedUser = await auth.currentUser();
    assert(checkUser.uid == returnedUser.uid);

    return returnedUser;
  }

  void moveToRegister() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize=MediaQuery.of(context).size;

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text('Account'),
      ),
      body: new Container(
        width: screenSize.width,
        padding: new EdgeInsets.all(20.0),
        child: new Form(
          key: this._formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs()+ buildSubmitButtons(),
          ),
        ),
      ),
    );
  }
  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return [
        new TextFormField(
          decoration: new InputDecoration(
              labelText: "email"
          ),
          onSaved: (val) => credentials.email = val,
          validator: (val) => val == '' ? val : null,
        ),
        new TextFormField(
          decoration: new InputDecoration(
            labelText: "password",
          ),
          obscureText: true,
          onSaved: (val) => credentials.password = val,
          validator: (val) => val == '' ? val : null,
        ),
      ];
    } else {
      return [
        new TextFormField(
          decoration: new InputDecoration(
              labelText: "email"
          ),
          onSaved: (val) => credentials.email = val,
          validator: (val) => val == '' ? val : null,
        ),
        new TextFormField(
            decoration: new InputDecoration(
            labelText: "password",
          ),
          obscureText: true,
          onSaved: (val) => credentials.password = val,
          validator: (val) => val == '' ? val : null,
        ),
        new TextFormField(
          decoration: new InputDecoration(
            labelText: "re-enter password",
          ),
          onSaved: (val) => val,
          validator: (val) {
            if (val != credentials.password) {
              return 'Passwords do not match';
            }
          },
          obscureText: true,
        ),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
            child: new Text(
              'Log in', style: new TextStyle(
                color: Colors.white
            ),
            ),
            onPressed: signIn),
        FlatButton(
          child: Text(
            'Create an account', style: new TextStyle(
              color: Colors.blue
          ),
          ),
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        RaisedButton(
            child: new Text(
              'Create account', style: new TextStyle(
                color: Colors.white
            ),
            ),
            onPressed: signIn),
        FlatButton(
          child: Text(
            'Already have account? Login', style: new TextStyle(
              color: Colors.blue
          ),
          ),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}