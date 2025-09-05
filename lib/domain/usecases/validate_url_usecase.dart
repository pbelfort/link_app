enum ValidateUrlType { empty, invalidFormat, validFormat }

class ValidateUrlUseCase {
  ValidateUrlType? call(String url) {
    if (url.isEmpty) return ValidateUrlType.empty;

    final uri = Uri.tryParse(url);
    final isValid = uri != null && (uri.isAbsolute || uri.hasScheme);

    if (!isValid) return ValidateUrlType.invalidFormat;

    return ValidateUrlType.validFormat;
  }
}
