import 'package:link_app/domain/entities/alias_entity.dart';
import '../../data/remote/i_alias_remote.dart';

class CreateAliasUseCase {
  final IAliasRemote _remoteDatasource;

  CreateAliasUseCase(this._remoteDatasource);

  Future<AliasEntity> call(String url) async {
    if (url.isEmpty) {
      throw ArgumentError('URL não pode ser vazia');
    }

    final response = await _remoteDatasource.createAlias(url);

    return response.fold(
      (failure) => throw Exception(failure.message),
      (alias) => alias,
    );
  }
}
