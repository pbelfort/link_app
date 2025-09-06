enum ValidateUrlType { empty, invalidFormat, validFormat }

class ValidateUrlUseCase {
  (bool, ValidateUrlType) call(String? url) {
    if (url == null || url.isEmpty) return (false, ValidateUrlType.empty);

    final uri = Uri.tryParse(url);
    final isValid = uri != null && (uri.isAbsolute || uri.hasScheme);

    if (!isValid) return (false, ValidateUrlType.invalidFormat);

    return (true, ValidateUrlType.validFormat);
  }
}
