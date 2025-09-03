import 'package:link_app/data/remote/i_alias_remote.dart';
import 'package:link_app/domain/entities/alias_entity.dart';
import 'package:link_app/domain/repositories/alias/i_alias_repository.dart';

class AliasRepository implements IAliasRepository {
  final IAliasRemote _urlShortenerService;

  AliasRepository(this._urlShortenerService);

  @override
  Future<AliasResponse> createAlias(String url) async {
    return await _urlShortenerService.createAlias(url);
  }

  @override
  Future<List<AliasEntity>> getAliasHistory() async {
    return [];
  }
}
