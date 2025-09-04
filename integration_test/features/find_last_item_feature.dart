import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_app/presentation/screens/home_screen.dart';
import 'package:link_app/presentation/widgets/link_tile.dart';

Future<void> findLastItemFeature(WidgetTester tester) async {
  final listFinder = find.descendant(
    of: find.byKey(kCustomScrollViewKey),
    matching: find.byType(Scrollable),
  );
  final itemFinder = find.byType(LinkTile).last;
  expect(itemFinder, findsOneWidget);

  await tester.scrollUntilVisible(itemFinder, 500.0, scrollable: listFinder);
  await tester.pumpAndSettle();
  final lastItemFinder = find.byKey(const ValueKey('www.google+0.com'));

  expect(lastItemFinder, findsOneWidget);
}
