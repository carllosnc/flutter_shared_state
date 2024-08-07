import 'package:flutter/material.dart';
import 'package:flutter_shared_state/modules/counter/counter_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('counter page', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CounterPage(),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('counter_page')), findsOneWidget);
    expect(find.byKey(const ValueKey('counter_value')), findsOneWidget);
    expect(find.byKey(const ValueKey('increment_button')), findsOneWidget);
    expect(find.byKey(const ValueKey('decrement_button')), findsOneWidget);
  });

  testWidgets('increment and decrement buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CounterPage(),
    ));
    await tester.pumpAndSettle();

    var incrementButton = find.byKey(const ValueKey('increment_button'));
    var decrementButton = find.byKey(const ValueKey('decrement_button'));

    await tester.tap(incrementButton);
    await tester.tap(incrementButton);
    await tester.tap(incrementButton);

    await tester.pumpAndSettle();
    expect(find.text('3'), findsOneWidget);

    await tester.tap(decrementButton);
    await tester.tap(decrementButton);
    await tester.tap(decrementButton);

    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
  });
}
