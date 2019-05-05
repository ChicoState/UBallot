//to run:  flutter test test_driver/question_test.dart
import 'package:test/test.dart';
import 'package:uballot/Widgets/Question.dart';

void main() {
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