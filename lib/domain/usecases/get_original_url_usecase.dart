import 'package:link_app/core/adapters/http/i_http_adpter.dart';

class GetOriginalUrlUseCase {
  final IHttpAdapter http;
  final String baseUrl = 'https://url-shortener-server.onrender.com/api/alias';

  GetOriginalUrlUseCase(this.http);

  Future<String> call(String alias) async {
    final data = await http.get('$baseUrl/$alias');
    return data['url'];
  }
}
