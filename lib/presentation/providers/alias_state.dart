import 'package:link_app/domain/entities/alias_entity.dart';

class AliasState {
  final List<AliasEntity> history;
  final bool loading;

  AliasState({this.history = const [], this.loading = false});

  AliasState copyWith({List<AliasEntity>? history, bool? loading}) {
    return AliasState(
      history: history ?? this.history,
      loading: loading ?? this.loading,
    );
  }
}
