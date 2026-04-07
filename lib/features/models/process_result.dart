class ProcessResult {
  final bool success;
  final String? error;

  ProcessResult({required this.success, this.error});

  factory ProcessResult.failure(String message) =>
      ProcessResult(success: false, error: message);

  factory ProcessResult.ok() => ProcessResult(success: true);
}
