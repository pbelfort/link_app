import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/presentation/providers/alias_state.dart';
import '../../domain/usecases/create_alias_usecase.dart';

final urlProvider = StateNotifierProvider<AliasProvider, AliasState>(
  (ref) => AliasProvider(),
);

class AliasProvider extends StateNotifier<AliasState> {
  final CreateAliasUseCase _createUrlAliasUseCase = GetIt.I
      .get<CreateAliasUseCase>();

  AliasProvider() : super(AliasState());

  Future<void> createAlias({
    required String url,
    required BuildContext context,
  }) async {
    if (url.isEmpty) return;
    state = state.copyWith(loading: true);
    try {
      final alias = await _createUrlAliasUseCase.call(url);
      state = state.copyWith(history: [alias, ...state.history]);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao encurtar URL')));
      rethrow;
    } finally {
      state = state.copyWith(loading: false);
    }
  }
}
