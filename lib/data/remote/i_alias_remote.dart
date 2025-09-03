import 'package:link_app/domain/entities/alias_entity.dart';

abstract class IAliasRemote {
  Future<AliasEntity> shortenUrl(String url);
}
