import 'package:link_app/domain/entities/alias_entity.dart';

class AliasState {
  final List<AliasEntity> history;
  final bool loading;
  final String? errorMessage;

  AliasState({
    this.history = const [],
    this.loading = false,
    this.errorMessage,
  });

  AliasState copyWith({
    List<AliasEntity>? history,
    bool? loading,
    String? errorMessage,
  }) {
    return AliasState(
      history: history ?? this.history,
      loading: loading ?? this.loading,
      errorMessage: errorMessage,
    );
  }
}
