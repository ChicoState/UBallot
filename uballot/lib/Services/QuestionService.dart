import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Question.dart';
import 'dart:async';

final CollectionReference questionsCollection = Firestore.instance.collection('Questions');

class QuestionService{
  static final QuestionService _instance = new QuestionService.internal();

  factory QuestionService() => _instance;

  QuestionService.internal();

  Future<Question> createQuestion(String statement, String answer, String A, String B, String C, String D) async{
    final TransactionHandler createTransaction = (Transaction tx) async{
      final DocumentSnapshot ds = await tx.get(questionsCollection.document());
      
      final Question question = new Question(ds.documentID, statement, answer, A, B, C, D);
      final Map<String, dynamic> data = question.toMap();
      
      await tx.set(ds.reference, data);
      return data;
    };
    
    return Firestore.instance.runTransaction(createTransaction).then((mapData){
      return Question.fromMap(mapData);
    }).catchError((error){
      print('error: $error');
      return null;
    });

  }

  /*Future<DocumentSnapshot> getQuestions(String id) async{
    return questionsCollection.document(id).get();
  }*/

  Stream<QuerySnapshot> getQuestions() {
    return questionsCollection.snapshots();
  }

  Future<dynamic> updateQuestion(Question question) async{
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(questionsCollection.document(question.id));

      await tx.update(ds.reference, question.toMap());
      return{'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error){
          print('error: $error');
          return false;
    });
  }

  Future<dynamic> deleteQuestion(String id) async{
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(questionsCollection.document(id));

      await tx.delete(ds.reference);
      return{'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
          print('error: $error');
          return false;
    });
  }
}