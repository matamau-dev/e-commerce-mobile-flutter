import 'package:dio/dio.dart';
import 'package:e_commerce/features/http/auth_interceptor.dart';
import 'package:e_commerce/features/providers/auth_provider.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api/v1',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  static void init(AuthProvider authProvider) {
    dio.interceptors.add(AuthInterceptor(dio, authProvider));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
