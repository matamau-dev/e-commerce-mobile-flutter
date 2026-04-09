import 'package:e_commerce/features/models/process_result.dart';
import 'package:e_commerce/presentation/widgets/feedback/custom_snackbar.dart';
import 'package:flutter/material.dart';

class UiHandler {
  static Future<void> handleProcessing({
    required BuildContext context,
    required Future<ProcessResult> Function() action,
    String? successMessage,
    VoidCallback? onSuccess,
  }) async {
    final result = await action();

    if (!context.mounted) return;

    if (result.success) {
      if (successMessage != null) {
        CustomSnackbar.show(
          context,
          message: successMessage,
          type: SnackbarType.success,
        );
      }
      onSuccess?.call();
    } else {
      CustomSnackbar.show(
        context,
        message: result.error ?? "Error desconocido",
        type: SnackbarType.error,
      );
    }
  }
}
