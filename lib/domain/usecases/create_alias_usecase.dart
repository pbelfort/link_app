import 'package:link_app/domain/entities/alias_entity.dart';
import 'package:link_app/domain/repositories/alias/i_alias_repository.dart';

class CreateAliasUseCase {
  final IAliasRepository _repository;

  CreateAliasUseCase(this._repository);

  Future<AliasEntity> call(String url) async {
    if (url.isEmpty) {
      throw ArgumentError('URL não pode ser vazia');
    }

    final response = await _repository.createAlias(url);

    return response.fold(
      (failure) => throw Exception(failure.message),
      (alias) => alias,
    );
  }
}
