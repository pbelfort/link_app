import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/presentation/providers/url_state.dart';
import '../../domain/entities/shortened_link_entity.dart';
import '../../domain/usecases/shorten_url_usecase.dart';

final urlProvider = StateNotifierProvider<UrlProvider, UrlState>(
  (ref) => UrlProvider(),
);

class UrlProvider extends StateNotifier<UrlState> {
  final ShortenUrlUseCase _shortenUrlUseCase = GetIt.I.get<ShortenUrlUseCase>();

  bool _loading = false;

  UrlProvider() : super(UrlState());

  List<ShortenedLinkEntity> get history => state.history;
  bool get loading => _loading;

  Future<void> shorten(String url) async {
    if (url.isEmpty) return;

    _loading = true;

    try {
      // Usecase retorna a entidade
      final ShortenedLinkEntity link = await _shortenUrlUseCase.call(url);
      state = state.copyWith(history: [link, ...state.history]);
    } catch (e) {
      rethrow;
    } finally {
      _loading = false;
    }
  }
}
