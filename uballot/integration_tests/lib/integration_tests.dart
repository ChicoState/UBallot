library integration_tests;

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


import '../../lib/home.dart;


void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    final app = MyApp();
    await tester.pumpWidget(app);
    expect(find.text("0"), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text("1"), findsOneWidget);
  });
}