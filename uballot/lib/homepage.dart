/*
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}




class _HomePage extends State<HomePage> {

  FirebaseUser user;

  getUIDFromFirebase() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();

    if(_user!=null) {
      setState(() {
        user = _user;
      });
    }
  }


  @override
  void initState() {
    getUIDFromFirebase();
//get stuff from firebase
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('asdasdsdsd'),
      ),
      body: Container(
        child: Row(
         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('sdsdsd'),
                Firestore.instance.collection('/user').document(user.uid).get()
              ],
            ),Column(
              children: <Widget>[
                Text('sdsdsd'),
                Text('sdsd'),

              ],
            ),
          ],
        ),
      ),
    );
  }

}
*/