//to run:  flutter test test_driver/responseTest.dart
import 'package:test/test.dart';
import 'package:uballot/Models/Response.dart';

void main() {
  test('response to json question', () {
    final response = Response();
    response.question = 'What is 2 + 2?';
    response.A = '3';
    response.B = '4';
    response.C = '5';
    response.D = '1';
    response.E = '2';
    response.FeedBack = '(1+1) + (1+1) = 4';
    response.correctAnswer = 'B';
    response.response = 'B';

    var json = response.responseToJson();

    expect(json['question'], response.question);
  });
  test('response to json A', () {
    final response = Response();
    response.question = 'What is 2 + 2?';
    response.A = '3';
    response.B = '4';
    response.C = '5';
    response.D = '1';
    response.E = '2';
    response.FeedBack = '(1+1) + (1+1) = 4';
    response.correctAnswer = 'B';
    response.response = 'B';

    var json = response.responseToJson();

    expect(json['A'], response.A);
  });
  test('response to json B', () {
    final response = Response();
    response.question = 'What is 2 + 2?';
    response.A = '3';
    response.B = '4';
    response.C = '5';
    response.D = '1';
    response.E = '2';
    response.FeedBack = '(1+1) + (1+1) = 4';
    response.correctAnswer = 'B';
    response.response = 'B';

    var json = response.responseToJson();

    expect(json['B'], response.B);
  });
  test('response to json C', () {
    final response = Response();
    response.question = 'What is 2 + 2?';
    response.A = '3';
    response.B = '4';
    response.C = '5';
    response.D = '1';
    response.E = '2';
    response.FeedBack = '(1+1) + (1+1) = 4';
    response.correctAnswer = 'B';
    response.response = 'B';

    var json = response.responseToJson();

    expect(json['C'], response.C);
  });
  test('response to json D', () {
    final response = Response();
    response.question = 'What is 2 + 2?';
    response.A = '3';
    response.B = '4';
    response.C = '5';
    response.D = '1';
    response.E = '2';
    response.FeedBack = '(1+1) + (1+1) = 4';
    response.correctAnswer = 'B';
    response.response = 'B';

    var json = response.responseToJson();
    expect(json['D'], response.D);
  });
  test('response to json E', () {
    final response = Response();
    response.question = 'What is 2 + 2?';
    response.A = '3';
    response.B = '4';
    response.C = '5';
    response.D = '1';
    response.E = '2';
    response.FeedBack = '(1+1) + (1+1) = 4';
    response.correctAnswer = 'B';
    response.response = 'B';

    var json = response.responseToJson();

    expect(json['E'], response.E);
  });
  test('response to json feedback', () {
    final response = Response();
    response.question = 'What is 2 + 2?';
    response.A = '3';
    response.B = '4';
    response.C = '5';
    response.D = '1';
    response.E = '2';
    response.FeedBack = '(1+1) + (1+1) = 4';
    response.correctAnswer = 'B';
    response.response = 'B';

    var json = response.responseToJson();

    expect(json['FeedBack'], response.FeedBack);
  });
  test('response to json correctAnswer', () {
    final response = Response();
    response.question = 'What is 2 + 2?';
    response.A = '3';
    response.B = '4';
    response.C = '5';
    response.D = '1';
    response.E = '2';
    response.FeedBack = '(1+1) + (1+1) = 4';
    response.correctAnswer = 'B';
    response.response = 'B';

    var json = response.responseToJson();

    expect(json['correctAnswer'], response.correctAnswer);
  });
  test('response to json response', () {
    final response = Response();
    response.question = 'What is 2 + 2?';
    response.A = '3';
    response.B = '4';
    response.C = '5';
    response.D = '1';
    response.E = '2';
    response.FeedBack = '(1+1) + (1+1) = 4';
    response.correctAnswer = 'B';
    response.response = 'B';

    var json = response.responseToJson();

    expect(json['response'], response.response);
  });
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
    response.response = 'B';

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

  test('response from json question', () {
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
  });
  test('response from json A', () {
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

    expect(r['A'], json['A'] );
  });
  test('response from json B', () {
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

    expect(r['B'], json['B'] );
  });
  test('response from json C', () {
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

    expect(r['C'], json['C']);
  });
  test('response from json D', () {
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

    expect(r['D'], json['D'] );
  });
  test('response from json E', () {
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

    expect(r['E'], json['E'] );
  });
  test('response from json feedback', () {
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

    expect(r['FeedBack'], json['FeedBack'] );
  });
  test('response from json correctAnswer', () {
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

    expect(r['correctAnswer'], json['correctAnswer'] );
  });
  test('response from json response', () {
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

    expect(r['response'], json['response'] );
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
    expect(r['response'], json['response'] );
  });
}