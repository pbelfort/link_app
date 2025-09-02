import 'package:link_app/core/adapters/http/i_http_adpter.dart';
import 'package:link_app/data/models/shortened_link_model.dart';
import 'package:link_app/domain/entities/shortened_link_entity.dart';

class UrlShortenerService {
  final IHttpAdapter http;
  final String baseUrl = 'https://url-shortener-server.onrender.com/api/alias';

  UrlShortenerService(this.http);

  Future<ShortenedLinkEntity> shortenUrl(String url) async {
    final data = await http.post(baseUrl, {'url': url});
    return ShortenedLinkModel.fromJson(data);
  }
}
