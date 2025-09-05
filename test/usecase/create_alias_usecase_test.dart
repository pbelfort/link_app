import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_app/data/remote/alias_remote.dart';
import 'package:link_app/domain/entities/alias_entity.dart';
import 'package:link_app/domain/repositories/alias/alias_repository.dart';
import 'package:link_app/domain/usecases/create_alias_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_alias_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AliasRemote>()])
void main() {
  late final MockAliasRemote mockAliasRemote;
  late final AliasRepository aliasRepository;
  late final CreateAliasUseCase createAliasUseCase;

  setUp(() {
    mockAliasRemote = MockAliasRemote();
    aliasRepository = AliasRepository(mockAliasRemote);
    createAliasUseCase = CreateAliasUseCase(aliasRepository);
  });

  test('when request is successful', () async {
    when(mockAliasRemote.createAlias('http://www.google.com')).thenAnswer(
      (_) async => Right(
        AliasEntity(
          alias: '702889725',
          original: 'http://www.google.com',
          short:
              'https://url-shortener-server.onrender.com/api/alias/702889725',
        ),
      ),
    );

    final result = await createAliasUseCase.call('http://www.google.com');
    expect(result, isA<AliasEntity>());
  });
}
