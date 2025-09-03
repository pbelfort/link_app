import 'package:link_app/core/adapters/http/i_http_adpter.dart';
import 'package:link_app/data/models/alias_model.dart';
import 'package:link_app/domain/entities/alias_entity.dart';

class UrlShortenerService {
  final IHttpAdapter http;
  final String baseUrl = 'https://url-shortener-server.onrender.com/api/alias';

  UrlShortenerService(this.http);

  Future<AliasEntity> shortenUrl(String url) async {
    final data = await http.post(baseUrl, {'url': url});
    return AliasModel.fromJson(data);
  }
}
