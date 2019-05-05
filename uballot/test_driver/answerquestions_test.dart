//to run:  flutter test test_driver/answerQuestionsTest.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uballot/answerquestions.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  /* ClassFromFirebase */
  testWidgets('load classfromfirebase', (WidgetTester tester) async {
    final classFromFireBase = new MediaQuery(data: new MediaQueryData(), child: new MaterialApp(home: new ClassesFromFirebase()));
    await tester.pumpWidget(classFromFireBase);
  });

  testWidgets('navigate classfromfirebase', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final classFromFirebase = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
          home: new ClassesFromFirebase(),
          navigatorObservers: [mockObserver],
        )
    );
    await tester.pumpWidget(classFromFirebase);
    verify(mockObserver.didPush(any, any));

  });

  /* QuizzesFromFirebase */

  testWidgets('load quizzesfromfirebase', (WidgetTester tester) async {
    final quizzesFromFirebase = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new QuizzesFromFirebase(className: 'Class1',)
        )
    );
    await tester.pumpWidget(quizzesFromFirebase);
  });

  testWidgets('navigate quizzesfromfirebase', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final quizzesFromFireBase = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
          home: new QuizzesFromFirebase(className: 'Class1',),
          navigatorObservers: [mockObserver],
        )
    );
    await tester.pumpWidget(quizzesFromFireBase);
    verify(mockObserver.didPush(any, any));

  });

/* DEAD CODE: QuestionsFromFirebase */

}