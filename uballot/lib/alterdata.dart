import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'object.dart';




class ChangeDatabase {

  Future<void> addData(object) async {
    //FIX check logged in
    Firestore.instance.collection('Answers_to_quiz').add(object).catchError((e) {
      print(e);
    });
  }

  updateData(docToChange,newValues){
    Firestore.instance.collection('Answers_to_quiz')
        .document('test')
        .updateData(newValues)
        .catchError((e){
          print(e);
    });
  }
}