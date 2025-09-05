import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/domain/usecases/validate_url_usecase.dart';
import 'package:link_app/presentation/providers/alias_state.dart';
import '../../domain/usecases/create_alias_usecase.dart';

final urlProvider = StateNotifierProvider<AliasProvider, AliasState>(
  (ref) => AliasProvider(),
);

class AliasProvider extends StateNotifier<AliasState> {
  final _createUrlAliasUseCase = GetIt.I.get<CreateAliasUseCase>();
  final _validateUrlUseCase = GetIt.I.get<ValidateUrlUseCase>();

  AliasProvider() : super(AliasState());

  Future<void> createAlias({required String url}) async {
    final isValid = _validateUrlUseCase.call(url);

    if (isValid == ValidateUrlType.empty) {
      state = state.copyWith(errorMessage: 'Please enter a URL');
      return;
    }

    if (isValid == ValidateUrlType.invalidFormat) {
      state = state.copyWith(errorMessage: 'Invalid URL format');
      return;
    }

    try {
      final alias = await _createUrlAliasUseCase.call(url);
      state = state.copyWith(history: [alias, ...state.history]);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(loading: false);
    }
  }
}
