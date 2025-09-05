import 'package:link_app/domain/entities/alias_entity.dart';

AliasEntity mapToEntity(Map<String, dynamic> json) {
  return AliasEntity(
    alias: json['alias'],
    original: json['_links']['self'],
    short: json['_links']['short'],
  );
}

AliasEntity modelToEntity(AliasEntity model) {
  return AliasEntity(
    alias: model.alias,
    original: model.original,
    short: model.short,
  );
}
