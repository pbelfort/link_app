import 'package:flutter_test/flutter_test.dart';
import 'package:link_app/data/mappers/alias_mapper.dart';
import 'package:link_app/data/models/alias_model.dart';
import 'package:link_app/domain/entities/alias_entity.dart';

void main() {
  group('AliasEntity', () {
    test('should create an instance correctly', () {
      final entity = AliasEntity(
        alias: 'abc123',
        original: 'https://example.com',
        short: 'https://short.ly/abc123',
      );
      expect(entity.alias, 'abc123');
      expect(entity.original, 'https://example.com');
      expect(entity.short, 'https://short.ly/abc123');
    });

    test('convert model to entity', () {
      final json = {
        "alias": "702889725",
        "_links": {
          "self": "www.google.com",
          "short":
              "https://url-shortener-server.onrender.com/api/alias/702889725",
        },
      };

      final model = AliasModel.fromJson(json);
      final entity = modelToEntity(model);

      expect(model, isA<AliasModel>());
      expect(entity, isA<AliasEntity>());
      expect(entity.alias, model.alias);
      expect(entity.original, model.original);
      expect(entity.short, model.short);
    });
  });
}
