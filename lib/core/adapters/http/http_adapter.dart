import 'dart:convert';

import 'package:link_app/core/adapters/http/i_http_adpter.dart';
import 'package:http/http.dart' as http;

class HttpAdapter implements IHttpAdapter {
  final http.Client client;

  HttpAdapter(this.client);

  @override
  Future<Map<String, dynamic>> get(String url) async {
    final response = await client.get(Uri.parse(url));

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
    final response = await client.post(
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
