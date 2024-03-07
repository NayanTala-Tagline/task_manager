import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/main.dart' as app;

void main() {
  testWidgets('Test Task Manager Flow', (WidgetTester tester) async {
    try {
      await tester.pumpWidget(const app.MyApp());
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 3));

      // Tap on the add button
      final button = find.byType(FloatingActionButton);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 2));

      // Enter the task name
      final name = find.byKey(const ValueKey("first"));
      await tester.enterText(name, 'Widget Test');
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      // Enter the description
      final desc = find.byKey(const ValueKey("second"));
      await tester.enterText(desc, 'Testing.....');
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      // Tap on the Add Task Button
      final add = find.text('ADD');
      await tester.tap(add);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Tap on the Delete Task Button
      final delete = find.bySubtype<Icon>().first;
      await tester.tap(delete);
      await tester.pump(const Duration(seconds: 2));
    } catch (e) {
      print('Exception: $e');
    }
  });
}
