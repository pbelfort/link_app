import 'package:get_it/get_it.dart';
import 'package:link_app/core/adapters/http/http_adapter.dart';
import 'package:link_app/core/adapters/http/i_http_adpter.dart';
import 'package:link_app/data/remote/alias_remote.dart';
import 'package:link_app/domain/repositories/alias/alias_repository.dart';
import 'package:link_app/domain/repositories/alias/i_alias_repository.dart';
import 'package:link_app/domain/usecases/validate_url_usecase.dart';
import '../../data/remote/i_alias_remote.dart';
import '../../domain/usecases/create_alias_usecase.dart';

final _getIt = GetIt.instance;

void setupLocator() {
  // adapter
  _getIt.registerLazySingleton<IHttpAdapter>(() => HttpAdapter());

  // remote
  _getIt.registerLazySingleton<IAliasRemote>(
    () => AliasRemote(_getIt.get<IHttpAdapter>()),
  );

  // repository
  _getIt.registerLazySingleton<IAliasRepository>(
    () => AliasRepository(_getIt.get<IAliasRemote>()),
  );

  // usecase
  _getIt.registerLazySingleton<CreateAliasUseCase>(
    () => CreateAliasUseCase(_getIt.get<IAliasRepository>()),
  );

  _getIt.registerLazySingleton<ValidateUrlUseCase>(() => ValidateUrlUseCase());
}
