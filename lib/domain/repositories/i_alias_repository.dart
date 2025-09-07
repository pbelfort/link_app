import 'package:link_app/domain/entities/alias_entity.dart';

abstract class IAliasRepository {
  Future<AliasEntity> createAlias(String url);
  Future<List<AliasEntity>> getAliasHistory();
}
