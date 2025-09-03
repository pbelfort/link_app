import 'package:dartz/dartz.dart';
import 'package:link_app/core/error/failure.dart';
import 'package:link_app/domain/entities/alias_entity.dart';

typedef AliasResponse = Either<Failure, AliasEntity>;

abstract class IAliasRemote {
  Future<AliasResponse> createAlias(String url);
}
