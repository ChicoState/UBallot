import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Quiz.dart';
import 'dart:async';

final CollectionReference quizCollection = Firestore.instance.collection('Quizzes');

class QuizService{
  static final QuizService _instance = new QuizService.internal();

  factory QuizService() => _instance;

  QuizService.internal();

  Future<Quiz> createQuiz(String className, List<Map<String, Map<String, Map<String,String>>>> classes) async{
    final TransactionHandler createTransaction = (Transaction tx) async{
      final DocumentSnapshot ds = await tx.get(quizCollection.document());

      final Quiz quiz = new Quiz(className, classes);
      final Map<String, dynamic> data = quiz.toMap();

      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData){
      return Quiz.fromMap(mapData);
    }).catchError((error){
      print('error: $error');
      return null;
    });

  }

  Stream<QuerySnapshot> getQuiz(){//String  uid) {
    //return quizCollection.where('uid', isEqualTo: uid).snapshots();
    return quizCollection.snapshots();
  }


  Future<dynamic> updateQuiz(Quiz quiz) async{
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(quizCollection.document(quiz.className));

      await tx.update(ds.reference, quiz.toMap());
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

  Future<dynamic> deleteQuiz(String className) async{
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(quizCollection.document(className));

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


/**
class QuizService{
  static final QuizService _instance = new QuizService.internal();

  factory QuizService() => _instance;

  QuizService.internal();

  Future<Quiz> createQuiz(String uid, String name, List<DocumentReference> questions) async{
    final TransactionHandler createTransaction = (Transaction tx) async{
      final DocumentSnapshot ds = await tx.get(quizCollection.document());

      final Quiz quiz = new Quiz(ds.documentID, uid, name, questions);
      final Map<String, dynamic> data = quiz.toMap();

      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData){
      return Quiz.fromMap(mapData);
    }).catchError((error){
      print('error: $error');
      return null;
    });

  }

  Stream<QuerySnapshot> getQuiz(){//String  uid) {
    //return quizCollection.where('uid', isEqualTo: uid).snapshots();
    return quizCollection.snapshots();
  }


  Future<dynamic> updateQuiz(Quiz quiz) async{
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(quizCollection.document(quiz.id));

      await tx.update(ds.reference, quiz.toMap());
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

  Future<dynamic> deleteQuiz(String id) async{
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(quizCollection.document(id));

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
 */