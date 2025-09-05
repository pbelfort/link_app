import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> createAliasFeature(WidgetTester tester) async {
  await tester.enterText(find.byType(TextField), 'http://www.google.com');
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.send));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
}
