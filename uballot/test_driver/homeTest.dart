import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uballot/home.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {

  testWidgets('load home page test', (WidgetTester tester) async {
    final home = new MediaQuery(data: new MediaQueryData(), child: new MaterialApp(home: new Home()));
    await tester.pumpWidget(home);
  });

  testWidgets('navigate test', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final home = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new Home(),
            navigatorObservers: [mockObserver],
        )
    );
    await tester.pumpWidget(home);
    verify(mockObserver.didPush(any, any));

  });

}