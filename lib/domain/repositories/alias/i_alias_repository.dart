import 'package:link_app/data/remote/i_alias_remote.dart';
import 'package:link_app/domain/entities/alias_entity.dart';

abstract class IAliasRepository {
  Future<AliasResponse> createAlias(String url);
  Future<List<AliasEntity>> getAliasHistory();
}
