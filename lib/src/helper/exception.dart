class MissingRequestException implements Exception {
  final String message;

  MissingRequestException(this.message);

  @override
  String toString() => 'MissingRequestException: $message';
}
