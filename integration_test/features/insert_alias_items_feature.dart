import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> insertAliasItemsFeature({
  required WidgetTester tester,
  required int numberOfItems,
}) async {
  for (int i = 0; i < numberOfItems; i++) {
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'http://www.google+$i.com');
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();
  }
  await Future.delayed(const Duration(seconds: 2));
}
