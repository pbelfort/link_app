import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/shortened_link.dart';

class UrlShortenerService {
  final String baseUrl = 'https://url-shortener-server.onrender.com/api/alias';

  Future<ShortenedLink> shortenUrl(String url) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'url': url}),
    );

    if (response.statusCode == 200) {
      return ShortenedLink.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao encurtar URL');
    }
  }
}
