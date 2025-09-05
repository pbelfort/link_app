import 'package:link_app/data/remote/i_alias_remote.dart';
import 'package:link_app/domain/entities/alias_entity.dart';
import 'package:link_app/domain/repositories/alias/i_alias_repository.dart';

class AliasRepository implements IAliasRepository {
  final IAliasRemote _aliasRemote;

  AliasRepository(this._aliasRemote);

  @override
  Future<AliasEntity> createAlias(String url) async {
    final result = await _aliasRemote.createAlias(url);
    return result.fold((failure) {
      throw Exception('${failure.message} (code: ${failure.errorCode})');
    }, (alias) => alias);
  }
}
