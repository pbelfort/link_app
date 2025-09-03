import 'package:link_app/domain/entities/alias_entity.dart';
import '../../data/remote/i_alias_remote.dart';

class CreateAliasUseCase {
  final IAliasRemote service;

  CreateAliasUseCase(this.service);

  Future<AliasEntity> call(String url) async {
    if (url.isEmpty) {
      throw ArgumentError('URL não pode ser vazia');
    }

    return await service.shortenUrl(url);
  }
}
