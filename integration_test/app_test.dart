import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:link_app/core/di/locator.dart';
import 'package:link_app/presentation/widgets/link_tile.dart';
import 'common/build_home_test.dart';
import 'features/create_alias_feature.dart';
import 'features/find_last_item_feature.dart';
import 'features/insert_alias_items_feature.dart';
import 'features/ui_widgets_feature.dart';

Future<void> main() async {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env');
    setupLocator();
  });

  group('end-to-end test', () {
    testWidgets('test ui widgets', (tester) async {
      await builHomeScreen(tester);
      uiWidgetsFeature();
    });

    testWidgets('test create alias', (tester) async {
      await builHomeScreen(tester);
      await createAliasFeature(tester);
      expect(find.byType(LinkTile), findsOneWidget);
    });

    testWidgets('insert alias items', (tester) async {
      await builHomeScreen(tester);
      await insertAliasItemsFeature(tester: tester, numberOfItems: 3);
      expect(find.byType(LinkTile), findsNWidgets(3));
    });

    testWidgets('check scroll when has more than five items', (tester) async {
      await builHomeScreen(tester);
      await insertAliasItemsFeature(tester: tester, numberOfItems: 8);
      await findLastItemFeature(tester);
    });
  });
}
