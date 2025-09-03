import 'dart:convert';
import 'package:http/http.dart';
import 'package:link_app/core/adapters/http/i_http_adpter.dart';

class HttpAdapter implements IHttpAdapter {
  final http = Client();

  HttpAdapter();

  @override
  Future<Map<String, dynamic>> get(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro GET ${response.statusCode}: ${response.body}');
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro POST ${response.statusCode}: ${response.body}');
    }
  }
}
