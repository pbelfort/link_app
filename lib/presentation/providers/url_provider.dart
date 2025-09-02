import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/shortened_link_entity.dart';
import '../../domain/usecases/shorten_url_usecase.dart';

final urlProvider = StateNotifierProvider<UrlProvider, UrlState>(
  (ref) => UrlProvider(),
);

class UrlState {
  final List<ShortenedLinkEntity> history;
  final bool loading;

  UrlState({this.history = const [], this.loading = false});

  UrlState copyWith({List<ShortenedLinkEntity>? history, bool? loading}) {
    return UrlState(
      history: history ?? this.history,
      loading: loading ?? this.loading,
    );
  }
}

class UrlProvider extends StateNotifier<UrlState> {
  final ShortenUrlUseCase _shortenUrlUseCase =
      GetIt.instance<ShortenUrlUseCase>();

  final List<ShortenedLinkEntity> _history = [];
  bool _loading = false;

  UrlProvider() : super(UrlState());

  List<ShortenedLinkEntity> get history => List.unmodifiable(_history);
  bool get loading => _loading;

  Future<void> shorten(String url) async {
    if (url.isEmpty) return;

    _loading = true;

    try {
      // Usecase retorna a entidade
      final ShortenedLinkEntity link = await _shortenUrlUseCase(url);
      _history.insert(0, link);
    } catch (e) {
      rethrow;
    } finally {
      _loading = false;
    }
  }
}
