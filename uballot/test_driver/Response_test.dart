//to run:  flutter test test_driver/responseTest.dart
import 'package:test/test.dart';
import 'package:uballot/Widgets/Response.dart';

void main() {
  test('response to json', () {
    final response = Response();
    response.question = 'What is 2 + 2?';
    response.A = '3';
    response.B = '4';
    response.C = '5';
    response.D = '1';
    response.E = '2';
    response.FeedBack = '(1+1) + (1+1) = 4';
    response.correctAnswer = 'B';
    response.correctAnswer = 'B';

    var json = response.responseToJson();

    expect(json['question'], response.question);
    expect(json['A'], response.A);
    expect(json['B'], response.B);
    expect(json['C'], response.C);
    expect(json['D'], response.D);
    expect(json['E'], response.E);
    expect(json['FeedBack'], response.FeedBack);
    expect(json['correctAnswer'], response.correctAnswer);
    expect(json['response'], response.response);


  });

  test('response from json', () {

    var response = new Response();
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
      'correctAnswer': 'B',
      'response': 'C'
    };
    var r  = response.responseFromJson(new Map<dynamic,dynamic>.from(json));

    expect(r['question'], json['question'] );
    expect(r['A'], json['A'] );
    expect(r['B'], json['B'] );
    expect(r['C'], json['C']);
    expect(r['D'], json['D'] );
    expect(r['E'], json['E'] );
    expect(r['FeedBack'], json['FeedBack'] );
    expect(r['correctAnswer'], json['correctAnswer'] );

  });
}