import 'package:link_app/domain/entities/alias_entity.dart';

class AliasModel extends AliasEntity {
  AliasModel({
    required super.alias,
    required super.original,
    required super.short,
  });

  factory AliasModel.fromJson(Map<String, dynamic> json) {
    return AliasModel(
      alias: json['alias'],
      original: json['_links']['self'],
      short: json['_links']['short'],
    );
  }
}
