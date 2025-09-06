import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/domain/entities/alias_entity.dart';
import 'package:link_app/domain/usecases/create_alias_usecase.dart';
import 'package:link_app/domain/usecases/validate_url_usecase.dart';
import 'package:link_app/presentation/providers/alias_provider.dart';
import 'package:mockito/mockito.dart';
import 'provider_alias_test.mocks.dart';

final testEmptyError = 'Field can not be empty';
final testInvalidFormatError =
    'Invalid URL format\nExample: http://www.example.com';
final kExampleUrl = 'https://example.com';

class FakeBuildContext {}

void main() {
  late MockCreateAliasUseCase mockAliasUseCase;
  late AliasProvider aliasProvider;

  setUp(() {
    mockAliasUseCase = MockCreateAliasUseCase();
    GetIt.I.registerSingleton<CreateAliasUseCase>(mockAliasUseCase);
    GetIt.I.registerSingleton<ValidateUrlUseCase>(ValidateUrlUseCase());
    aliasProvider = AliasProvider();
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('provider group tests', () {
    test('initial state test', () {
      expect(aliasProvider.state.history, isEmpty);
      expect(aliasProvider.state.loading, isFalse);
    });

    test('create one alias adding item to history', () async {
      final alias = AliasEntity(
        alias: 'abc',
        original: kExampleUrl,
        short: 'short',
      );
      when(mockAliasUseCase.call(kExampleUrl)).thenAnswer((_) async => alias);

      // Use um contexto fake ou adapte o método para não depender de contexto real
      await aliasProvider.createAlias(url: kExampleUrl);

      expect(aliasProvider.state.history.first, alias);
      expect(aliasProvider.state.errorMessage, isNull);
      expect(aliasProvider.state.history.length, 1);
      expect(aliasProvider.state.loading, isFalse);
    });

    test('try to create alias with empty value', () async {
      await aliasProvider.createAlias(url: '');
      expect(aliasProvider.state.errorMessage, testEmptyError);
      expect(aliasProvider.state.loading, isFalse);
    });

    test('create alias with invalid url format', () async {
      await aliasProvider.createAlias(url: 'example.com');
      expect(aliasProvider.state.errorMessage, testInvalidFormatError);
      expect(aliasProvider.state.loading, isFalse);
    });
  });
}
