//to run:  flutter test test_driver/takeQuizTest.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uballot/takequiz.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('load take quiz page test', (WidgetTester tester) async {
    final takeQuiz = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new TakeQuiz(
              quizName: 'quiz123',
              className: 'Class1',
            )
        )
    );
  });

}