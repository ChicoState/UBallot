//to run:  flutter test test_driver/question_test.dart
import 'package:test/test.dart';
import 'package:uballot/Models/Question.dart';

void main() {
  test('question to json question', () {
    final question = Question();
    question.question = 'What is 2 + 2?';
    question.A = '3';
    question.B = '4';
    question.C = '5';
    question.D = '1';
    question.E = '2';
    question.FeedBack = '(1+1) + (1+1) = 4';
    question.correctAnswer = 'B';

    var json = question.questionToJson();

    expect(json['question'], question.question);
  });
  test('question to json A', () {
    final question = Question();
    question.question = 'What is 2 + 2?';
    question.A = '3';
    question.B = '4';
    question.C = '5';
    question.D = '1';
    question.E = '2';
    question.FeedBack = '(1+1) + (1+1) = 4';
    question.correctAnswer = 'B';

    var json = question.questionToJson();

    expect(json['A'], question.A);
  });
  test('question to json B', () {
    final question = Question();
    question.question = 'What is 2 + 2?';
    question.A = '3';
    question.B = '4';
    question.C = '5';
    question.D = '1';
    question.E = '2';
    question.FeedBack = '(1+1) + (1+1) = 4';
    question.correctAnswer = 'B';

    var json = question.questionToJson();

    expect(json['B'], question.B);
  });
  test('question to json C', () {
    final question = Question();
    question.question = 'What is 2 + 2?';
    question.A = '3';
    question.B = '4';
    question.C = '5';
    question.D = '1';
    question.E = '2';
    question.FeedBack = '(1+1) + (1+1) = 4';
    question.correctAnswer = 'B';

    var json = question.questionToJson();

    expect(json['C'], question.C);
  });
  test('question to json D', () {
    final question = Question();
    question.question = 'What is 2 + 2?';
    question.A = '3';
    question.B = '4';
    question.C = '5';
    question.D = '1';
    question.E = '2';
    question.FeedBack = '(1+1) + (1+1) = 4';
    question.correctAnswer = 'B';

    var json = question.questionToJson();

    expect(json['D'], question.D);
  });
  test('question to json E', () {
    final question = Question();
    question.question = 'What is 2 + 2?';
    question.A = '3';
    question.B = '4';
    question.C = '5';
    question.D = '1';
    question.E = '2';
    question.FeedBack = '(1+1) + (1+1) = 4';
    question.correctAnswer = 'B';

    var json = question.questionToJson();

    expect(json['E'], question.E);
  });
  test('question to json Feedback', () {
    final question = Question();
    question.question = 'What is 2 + 2?';
    question.A = '3';
    question.B = '4';
    question.C = '5';
    question.D = '1';
    question.E = '2';
    question.FeedBack = '(1+1) + (1+1) = 4';
    question.correctAnswer = 'B';

    var json = question.questionToJson();

    expect(json['FeedBack'], question.FeedBack);
  });
  test('question to json correctAnswer', () {
    final question = Question();
    question.question = 'What is 2 + 2?';
    question.A = '3';
    question.B = '4';
    question.C = '5';
    question.D = '1';
    question.E = '2';
    question.FeedBack = '(1+1) + (1+1) = 4';
    question.correctAnswer = 'B';

    var json = question.questionToJson();

    expect(json['correctAnswer'], question.correctAnswer);
  });
  test('question to json', () {
    final question = Question();
    question.question = 'What is 2 + 2?';
    question.A = '3';
    question.B = '4';
    question.C = '5';
    question.D = '1';
    question.E = '2';
    question.FeedBack = '(1+1) + (1+1) = 4';
    question.correctAnswer = 'B';

    var json = question.questionToJson();

    expect(json['question'], question.question);
    expect(json['A'], question.A);
    expect(json['B'], question.B);
    expect(json['C'], question.C);
    expect(json['D'], question.D);
    expect(json['E'], question.E);
    expect(json['FeedBack'], question.FeedBack);
    expect(json['correctAnswer'], question.correctAnswer);
  });

  test('question from json question', () {

    var question = new Question();
    var json = new Map<dynamic,dynamic>();
    json = {
      'question': 'What is 2 + 2?',
      'A': '3',
      'B': '4',
      'C': '5',
      'D': '1',
      'E': '2',
      'FeedBack':
      '(1+1) + (1+1) = 4',
      'correctAnswer': 'B'
    };
    var q  = question.questionFromJson(new Map<dynamic,dynamic>.from(json));

    expect(q['question'], json['question'] );
  });
  test('question from json A', () {

    var question = new Question();
    var json = new Map<dynamic,dynamic>();
    json = {
      'question': 'What is 2 + 2?',
      'A': '3',
      'B': '4',
      'C': '5',
      'D': '1',
      'E': '2',
      'FeedBack':
      '(1+1) + (1+1) = 4',
      'correctAnswer': 'B'
    };
    var q  = question.questionFromJson(new Map<dynamic,dynamic>.from(json));

    expect(q['A'], json['A'] );
  });
  test('question from json B', () {

    var question = new Question();
    var json = new Map<dynamic,dynamic>();
    json = {
      'question': 'What is 2 + 2?',
      'A': '3',
      'B': '4',
      'C': '5',
      'D': '1',
      'E': '2',
      'FeedBack':
      '(1+1) + (1+1) = 4',
      'correctAnswer': 'B'
    };
    var q  = question.questionFromJson(new Map<dynamic,dynamic>.from(json));

    expect(q['B'], json['B'] );
  });
  test('question from json C', () {

    var question = new Question();
    var json = new Map<dynamic,dynamic>();
    json = {
      'question': 'What is 2 + 2?',
      'A': '3',
      'B': '4',
      'C': '5',
      'D': '1',
      'E': '2',
      'FeedBack':
      '(1+1) + (1+1) = 4',
      'correctAnswer': 'B'
    };
    var q  = question.questionFromJson(new Map<dynamic,dynamic>.from(json));

    expect(q['C'], json['C']);
  });
  test('question from json D', () {

    var question = new Question();
    var json = new Map<dynamic,dynamic>();
    json = {
      'question': 'What is 2 + 2?',
      'A': '3',
      'B': '4',
      'C': '5',
      'D': '1',
      'E': '2',
      'FeedBack':
      '(1+1) + (1+1) = 4',
      'correctAnswer': 'B'
    };
    var q  = question.questionFromJson(new Map<dynamic,dynamic>.from(json));

    expect(q['D'], json['D'] );
  });
  test('question from json E', () {

    var question = new Question();
    var json = new Map<dynamic,dynamic>();
    json = {
      'question': 'What is 2 + 2?',
      'A': '3',
      'B': '4',
      'C': '5',
      'D': '1',
      'E': '2',
      'FeedBack':
      '(1+1) + (1+1) = 4',
      'correctAnswer': 'B'
    };
    var q  = question.questionFromJson(new Map<dynamic,dynamic>.from(json));

    expect(q['E'], json['E'] );
  });
  test('question from json feedback', () {

    var question = new Question();
    var json = new Map<dynamic,dynamic>();
    json = {
      'question': 'What is 2 + 2?',
      'A': '3',
      'B': '4',
      'C': '5',
      'D': '1',
      'E': '2',
      'FeedBack':
      '(1+1) + (1+1) = 4',
      'correctAnswer': 'B'
    };
    var q  = question.questionFromJson(new Map<dynamic,dynamic>.from(json));

    expect(q['FeedBack'], json['FeedBack'] );
  });
  test('question from json correctAnswer', () {

    var question = new Question();
    var json = new Map<dynamic,dynamic>();
    json = {
      'question': 'What is 2 + 2?',
      'A': '3',
      'B': '4',
      'C': '5',
      'D': '1',
      'E': '2',
      'FeedBack':
      '(1+1) + (1+1) = 4',
      'correctAnswer': 'B'
    };
    var q  = question.questionFromJson(new Map<dynamic,dynamic>.from(json));

    expect(q['correctAnswer'], json['correctAnswer'] );
  });
  test('question from json', () {

    var question = new Question();
    var json = new Map<dynamic,dynamic>();
    json = {
      'question': 'What is 2 + 2?',
      'A': '3',
      'B': '4',
      'C': '5',
      'D': '1',
      'E': '2',
      'FeedBack':
      '(1+1) + (1+1) = 4',
      'correctAnswer': 'B'
    };
    var q  = question.questionFromJson(new Map<dynamic,dynamic>.from(json));

    expect(q['question'], json['question'] );
    expect(q['A'], json['A'] );
    expect(q['B'], json['B'] );
    expect(q['C'], json['C']);
    expect(q['D'], json['D'] );
    expect(q['E'], json['E'] );
    expect(q['FeedBack'], json['FeedBack'] );
    expect(q['correctAnswer'], json['correctAnswer'] );

  });
}