import 'package:link_app/domain/entities/shortened_link_entity.dart';

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
