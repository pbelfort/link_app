import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void uiWidgetsFeature() {
  expect(find.text('Recently shortened URLs'), findsOneWidget);
  expect(find.text('URL Shortener'), findsOneWidget);
  expect(find.byIcon(Icons.send), findsOneWidget);
  expect(find.byType(TextField), findsOneWidget);
}
