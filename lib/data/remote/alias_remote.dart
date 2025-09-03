import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:link_app/core/adapters/http/i_http_adpter.dart';
import 'package:link_app/core/error/failure.dart';
import 'package:link_app/data/models/alias_model.dart';
import 'package:link_app/data/remote/i_alias_remote.dart';

class AliasRemote implements IAliasRemote {
  final IHttpAdapter http;
  final baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  AliasRemote(this.http);

  @override
  Future<AliasResponse> createAlias(String url) async {
    try {
      final data = await http.post(baseUrl, {'url': url});
      return Right(AliasModel.fromJson(data));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
