class Failure {
  final int errorCode;
  final String message;
  Failure(this.message, this.errorCode);

  factory Failure.catchHttpError(e, String apiTrackCode) {
    if (e is Exception) {
      return Failure(e.toString(), 400);
    }
    return Failure('Unknown error at $apiTrackCode: $e', 500);
  }
}
