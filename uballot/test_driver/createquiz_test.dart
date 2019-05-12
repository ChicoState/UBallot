//to run:  flutter test test_driver/createQuizTest.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uballot/createquiz.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  /* newQuiz */
  testWidgets('load new quiz test', (WidgetTester tester) async {
    final newQuiz = new MediaQuery(data: new MediaQueryData(), child: new MaterialApp(home: new NewQuizName()));
    await tester.pumpWidget(newQuiz);
  });

  testWidgets('navigate test', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final newQuiz = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
          home: new NewQuizName(),
          navigatorObservers: [mockObserver],
        )
    );
    await tester.pumpWidget(newQuiz);
    verify(mockObserver.didPush(any, any));

  });
  testWidgets('navigate to creat quiz test', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final newQuiz = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
          home: new NewQuizName(),
          navigatorObservers: [mockObserver],
        )
    );
    await tester.pumpWidget(newQuiz);
    verify(mockObserver.didPush(any, any));

    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    verify(mockObserver.didPush(any, any));
    expect(find.byType(CreateQuiz), findsOneWidget);
  });

  /* createQuiz */
  testWidgets('load new quiz test', (WidgetTester tester) async {
    final createQuiz = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new CreateQuiz(titlequiz: 'mock quiz',)
        )
    );
    await tester.pumpWidget(createQuiz);
  });
  testWidgets('load create quiz test', (WidgetTester tester) async {
    final createQuiz = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new CreateQuiz(titlequiz: 'mock title',)
        )
    );
    await tester.pumpWidget(createQuiz);
  });

  testWidgets('navigate test', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final createQuiz = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
          home: new CreateQuiz(titlequiz: 'mock title',),
          navigatorObservers: [mockObserver],
        )
    );
    await tester.pumpWidget(createQuiz);
    verify(mockObserver.didPush(any, any));

  });



}