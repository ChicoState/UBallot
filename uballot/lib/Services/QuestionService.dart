import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Question.dart';

final CollectionReference questionsCollection = Firestore.instance.collection('Questions');

class 