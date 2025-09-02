import 'package:link_app/domain/entities/shortened_link_entity.dart';

class ShortenedLinkModel extends ShortenedLinkEntity {
  ShortenedLinkModel({
    required super.alias,
    required super.original,
    required super.short,
  });

  factory ShortenedLinkModel.fromJson(Map<String, dynamic> json) {
    return ShortenedLinkModel(
      alias: json['alias'],
      original: json['_links']['self'],
      short: json['_links']['short'],
    );
  }
}
