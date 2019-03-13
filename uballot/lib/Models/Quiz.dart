import 'package:cloud_firestore/cloud_firestore.dart';
import 'Question.dart';

class Quiz {

  String _id;
  String _name;
  List<DocumentReference> _questions;
  String _uid;

  Quiz(this._id, this._uid, this._name, this._questions);

  Quiz.map(dynamic obj){
    this._id = obj['id'];
    this._uid = obj['uid'];
    this._name = obj['name'];
    this._questions = obj['questions'];
  }

  String get id => _id;
  String get uid => _uid;
  String get name => _name;
  List<DocumentReference> get questions => _questions;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['uid'] = _uid;
    map['name'] = _name;
    map['questions'] = _questions;

    return map;
  }

  Quiz.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._uid = map['uid'];
    this._name = map['name'];
    this._questions = map['questions'];
  }
}