class ProcessResult {
  final bool success;
  final String? error;

  ProcessResult({required this.success, this.error});

  // Factory opcional para hacer el código más corto
  factory ProcessResult.failure(String message) =>
      ProcessResult(success: false, error: message);

  factory ProcessResult.ok() => ProcessResult(success: true);
}
