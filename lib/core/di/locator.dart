import 'package:get_it/get_it.dart';
import 'package:link_app/core/adapters/http/http_adapter.dart';
import 'package:link_app/core/adapters/http/i_http_adpter.dart';
import 'package:http/http.dart' as http;
import '../../data/services/url_shortener_service.dart';
import '../../domain/usecases/shorten_url_usecase.dart';

final _getIt = GetIt.instance;

void setupLocator() {
  // http adapter
  _getIt.registerLazySingleton<IHttpAdapter>(() => HttpAdapter(http.Client()));

  // services
  _getIt.registerLazySingleton<UrlShortenerService>(
    () => UrlShortenerService(_getIt<IHttpAdapter>()),
  );

  // usecases
  _getIt.registerLazySingleton<ShortenUrlUseCase>(
    () => ShortenUrlUseCase(_getIt<UrlShortenerService>()),
  );
}
