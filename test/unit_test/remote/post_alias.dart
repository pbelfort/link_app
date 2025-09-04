import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:link_app/data/models/alias_model.dart';
import 'package:link_app/domain/entities/alias_entity.dart';

Future<AliasEntity> createAlias(String url) async {
  await dotenv.load(fileName: '.env');
  final baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  try {
    final response = await http.post(
      headers: {'Content-Type': 'application/json'},
      Uri.parse(baseUrl),
      body: jsonEncode({'url': url}),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return AliasModel.fromJson(data);
  } catch (e) {
    throw Exception('Failed to create alias: $e');
  }
}
