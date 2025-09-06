import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/domain/usecases/validate_url_usecase.dart';
import 'package:link_app/presentation/providers/alias_state.dart';
import '../../domain/usecases/create_alias_usecase.dart';

final urlProvider = StateNotifierProvider<AliasProvider, AliasState>(
  (ref) => AliasProvider(),
);

const kEmptyError = 'Field can not be empty';
const kInvalidFormatError =
    'Invalid URL format\nExample: http://www.example.com';

class AliasProvider extends StateNotifier<AliasState> {
  final _createUrlAliasUseCase = GetIt.I.get<CreateAliasUseCase>();
  final _validateUrlUseCase = GetIt.I.get<ValidateUrlUseCase>();

  AliasProvider() : super(AliasState());

  String? validateUrl(String? url) {
    final (isValid, typeError) = _validateUrlUseCase.call(url);

    if (isValid) {
      state = state.copyWith(errorMessage: null);
      return null;
    }

    if (typeError == ValidateUrlType.empty) {
      state = state.copyWith(errorMessage: kEmptyError);
    }
    if (typeError == ValidateUrlType.invalidFormat) {
      state = state.copyWith(errorMessage: kInvalidFormatError);
    }

    return state.errorMessage;
  }

  Future<void> createAlias({required String url}) async {
    validateUrl(url);
    final hasError = state.errorMessage != null;
    if (hasError) return;
    state = state.copyWith(loading: true);
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
