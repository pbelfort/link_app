import 'package:link_app/domain/entities/shortened_link_entity.dart';
import '../../data/services/url_shortener_service.dart';

class ShortenUrlUseCase {
  final UrlShortenerService service;

  ShortenUrlUseCase(this.service);

  Future<ShortenedLinkEntity> call(String url) async {
    if (url.isEmpty) {
      throw ArgumentError('URL não pode ser vazia');
    }

    return await service.shortenUrl(url);
  }
}
