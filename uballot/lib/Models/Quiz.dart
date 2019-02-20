import 'package:cloud_firestore/cloud_firestore.dart';
import 'Question.dart';

class Quiz {

  String _name;
  List<DocumentReference> _questions;

  Quiz(this._name, this._questions);
  /** To Do: in utils
  Question get question(DocumentReference dr){}
  List<Question> get questions{} //need to ask question model
  String get name => this._name;
  Quiz
  **/
}