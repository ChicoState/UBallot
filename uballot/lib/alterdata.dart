import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'object.dart';




class ChangeDatabase {

  Future<void> addData(object) async {
    //FIX check logged in
    Firestore.instance.collection('something').add(object).catchError((e) {
      print(e);
    });
  }
}