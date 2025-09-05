import 'package:link_app/domain/entities/alias_entity.dart';
import 'package:link_app/domain/repositories/alias/i_alias_repository.dart';

class CreateAliasUseCase {
  final IAliasRepository _repository;

  CreateAliasUseCase(this._repository);

  Future<AliasEntity> call(String url) async {
    if (url.isEmpty) throw ArgumentError('URL cannot be empty');

    final isValidUrl = Uri.parse(url).host.isNotEmpty;

    if (!isValidUrl) {
      throw ArgumentError('Invalid URL format');
    }
    final response = await _repository.createAlias(url);

    return response;
  }
}
