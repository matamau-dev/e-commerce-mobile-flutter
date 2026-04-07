class ApiException implements Exception {
  final int statusCode;
  final String message;
  final bool isValidationError;

  ApiException({
    required this.statusCode,
    required this.message,
    this.isValidationError = false,
  });

  @override
  String toString() => message;
}
