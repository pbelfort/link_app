import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test/providers/provider_alias_test.dart';

Future<void> insertEmptyUrlFeature(WidgetTester tester) async {
  await tester.enterText(find.byType(TextField), '');
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.send));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  expect(find.text(testEmptyError), findsOneWidget);
}

Future<void> insertInvalidUrlFeature(WidgetTester tester) async {
  await tester.enterText(find.byType(TextField), 'invalid-url');
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.send));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  expect(find.text(testInvalidFormatError), findsOneWidget);
}
