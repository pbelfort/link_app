import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:link_app/domain/entities/alias_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'post_alias.dart';
import 'post_alias_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  test(
    'returns an Alias Entity if the http call completes successfully',
    () async {
      final client = MockClient();
      final url = "www.google.com";
      await dotenv.load(fileName: '.env');
      final baseUrl = dotenv.env['API_BASE_URL'] ?? '';
      when(
        client.post(
          Uri.parse(baseUrl),
          body: jsonEncode({'url': url}),
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"alias": "702889725","_links": {"self": "www.google.com","short": "https://url-shortener-server.onrender.com/api/alias/702889725"}}',
          200,
        ),
      );

      final response = await createAlias(url);

      expect(response, isA<AliasEntity>());
    },
  );
}
