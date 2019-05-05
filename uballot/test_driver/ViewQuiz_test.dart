//to run:  flutter test test_driver/viewQuizTest.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uballot/ViewQuiz.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  /* ViewQuiz */
  testWidgets('load view quiz test', (WidgetTester tester) async {
    final viewQuiz = new MediaQuery(data: new MediaQueryData(), child: new MaterialApp(home: new ViewQuiz()));
    await tester.pumpWidget(viewQuiz);
  });

  testWidgets('navigate view quiz', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final viewQuiz = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
          home: new ViewQuiz(),
          navigatorObservers: [mockObserver],
        )
    );
    await tester.pumpWidget(viewQuiz);
    verify(mockObserver.didPush(any, any));

  });
/** TODO: need to figure out how to test navigation without concrete text
  testWidgets('navigate to select quiz test', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final viewQuiz = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
          home: new ViewQuiz(),
          navigatorObservers: [mockObserver],
        )
    );
    await tester.pumpWidget(viewQuiz);
    verify(mockObserver.didPush(any, any));


    await tester.tap(find.widgetWithText(RaisedButton, 'Class1'));
    await tester.pumpAndSettle();
    verify(mockObserver.didPush(any, any));
    expect(find.byType(SelectQuiz), findsOneWidget);

  });
**/
  /* selectQuiz */
  testWidgets('load new quiz test', (WidgetTester tester) async {
    final selectQuiz = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new SelectQuiz(userName: 'Ek5uRAgbsPSVFZrRnsZKWvVWWYA2', className: 'Class1',)
        )
    );
    await tester.pumpWidget(selectQuiz);
  });

  testWidgets('navigate select quiz', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final selectQuiz = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
          home: new SelectQuiz(userName: 'Ek5uRAgbsPSVFZrRnsZKWvVWWYA2', className: 'Class1',),
          navigatorObservers: [mockObserver],
        )
    );
    await tester.pumpWidget(selectQuiz);
    verify(mockObserver.didPush(any, any));

  });

  /* ViewQuestions */
  testWidgets('load new quiz test', (WidgetTester tester) async {
    final viewQuestions = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new ViewQuestions(userName: 'Ek5uRAgbsPSVFZrRnsZKWvVWWYA2', className: 'Class1', quizName: 'Test Quiz',)
        )
    );
    await tester.pumpWidget(viewQuestions);
  });


}