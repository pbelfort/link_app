import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/domain/entities/alias_entity.dart';
import 'package:link_app/domain/usecases/create_alias_usecase.dart';
import 'package:link_app/domain/usecases/validate_url_usecase.dart';
import 'package:link_app/presentation/providers/alias_provider.dart';

import 'package:mockito/mockito.dart';

import 'provider_alias_test.mocks.dart';

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
        original: 'https://example.com',
        short: 'short',
      );
      when(
        mockAliasUseCase.call('https://example.com'),
      ).thenAnswer((_) async => alias);

      // Use um contexto fake ou adapte o método para não depender de contexto real
      await aliasProvider.createAlias(url: 'https://example.com');

      expect(aliasProvider.state.history.first, alias);
      expect(aliasProvider.state.errorMessage, isNull);
      expect(aliasProvider.state.history.length, 1);
      expect(aliasProvider.state.loading, isFalse);
    });

    test('try to create alias with empty value', () async {
      await aliasProvider.createAlias(url: '');
      expect(aliasProvider.state.errorMessage, 'Please enter a URL');
      expect(aliasProvider.state.loading, isFalse);
    });

    test('create alias with invalid url format', () async {
      when(
        mockAliasUseCase.call('example.com'),
      ).thenThrow(Exception('Invalid URL format'));

      await aliasProvider.createAlias(url: 'example.com');
      expect(aliasProvider.state.errorMessage, 'Invalid URL format');
      expect(aliasProvider.state.loading, isFalse);
    });
  });
}
