import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';




class ChangeDatabase {

  Future<void> addData(object) async {
    //FIX check logged in
    Firestore.instance.collection('Answers_to_quiz').add(object).catchError((e) {

      print(e);
    });

  }

  do_something(){
    final Firestore store =Firestore.instance;
    Firestore.instance.runTransaction((transaction) async {
      store.collection('testtest').add({'flutter':'derp derp'});
      //await transaction.set(Firestore.instance.collection("your_collection").document(), {
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