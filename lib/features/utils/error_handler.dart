// core/utils/error_handler.dart
import 'package:dio/dio.dart';
import '../exceptions/api_exception.dart';

class ErrorHandler {
  static ApiException fromDio(DioException e) {
    if (e.response?.data != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic>) {
        final rawMessage = data['message'];
        String finalMessage = "Error de validación";

        if (rawMessage is List) {
          finalMessage = rawMessage.map((item) => item.toString()).join('\n');
        } else if (rawMessage is String) {
          finalMessage = rawMessage;
        }

        return ApiException(
          statusCode: data['status'] ?? 400,
          message:
              finalMessage, // Ahora contiene los 4 errores separados por línea
        );
      }
    }
    return ApiException(statusCode: 500, message: "Error inesperado");
  }
}
