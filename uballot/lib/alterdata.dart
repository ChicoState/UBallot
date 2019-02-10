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

  updateData(docToChange,object){
    Firestore.instance.collection('Answers_to_quiz')
        .document('test')
        .updateData(object)
        .catchError((e){
          print(e);
    });
  }

  getData(object) async{
    return await Firestore.instance.collection('Answers_to_quiz').snapshots();
  }

  Future<bool> doesDataExist(object) async {

  }

}