import 'package:link_app/domain/entities/alias_entity.dart';
import '../../data/services/url_shortener_service.dart';

class CreateAliasUseCase {
  final UrlShortenerService service;

  CreateAliasUseCase(this.service);

  Future<AliasEntity> call(String url) async {
    if (url.isEmpty) {
      throw ArgumentError('URL não pode ser vazia');
    }

    return await service.shortenUrl(url);
  }
}
