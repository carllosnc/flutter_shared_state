import 'package:flutter/material.dart';
import 'package:flutter_shared_state/modules/todo_list/todo_list_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('check rendering of todo list', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: TodoListPage(),
    ));

    await tester.pumpAndSettle();

    //see empty message
    expect(find.byKey(const ValueKey('todo_list_empty_message')), findsOneWidget);
  });
}
