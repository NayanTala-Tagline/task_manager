// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:task_manager/main.dart' as app;

void main() {
  testWidgets('Test Task Manager Flow', (WidgetTester tester) async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    try {
      await tester.pumpWidget(const app.MyApp());
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 3));

      // Tap on the Signup button
      final button = find.byType(FloatingActionButton);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 2));

      // Enter the email Id
      final name = find.byKey(const ValueKey("first"));
      await tester.enterText(name, 'Widget Test');
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      // Enter the password
      final desc = find.byKey(const ValueKey("second"));
      await tester.enterText(desc, 'Testing.....');
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      // Tap on the Next Button

      final add = find.text('ADD');
      await tester.tap(add);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));
    } catch (e) {
      print('Exception: $e');
    }

    // final controller = TextEditingController(text: '1234');
    // final otps = find.byWidget(OtpFields(controller: controller));
    // await tester.enterText(otps);
  });
}
