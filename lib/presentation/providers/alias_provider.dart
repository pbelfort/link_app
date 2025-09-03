import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/presentation/providers/alias_state.dart';
import '../../domain/entities/alias_entity.dart';
import '../../domain/usecases/create_alias_usecase.dart';

final urlProvider = StateNotifierProvider<AliasProvider, AliasState>(
  (ref) => AliasProvider(),
);

class AliasProvider extends StateNotifier<AliasState> {
  final CreateAliasUseCase _createUrlAliasUseCase = GetIt.I
      .get<CreateAliasUseCase>();

  bool _loading = false;

  AliasProvider() : super(AliasState());

  List<AliasEntity> get history => state.history;
  bool get loading => _loading;

  Future<void> createAlias(String url) async {
    if (url.isEmpty) return;
    _loading = true;
    try {
      final AliasEntity link = await _createUrlAliasUseCase.call(url);
      state = state.copyWith(history: [link, ...state.history]);
    } catch (e) {
      rethrow;
    } finally {
      _loading = false;
    }
  }
}
