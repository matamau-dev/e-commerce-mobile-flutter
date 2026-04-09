import 'package:dio/dio.dart';
import 'package:e_commerce/features/providers/auth_provider.dart';
import 'package:e_commerce/features/utils/storage_service.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final AuthProvider _authProvider;
  AuthInterceptor(this._dio, this._authProvider);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print("Interceptando petición: ${options.method} ${options.path}");
    final token = _authProvider.token;
    print(" Token obtenido: $token");
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) return handler.next(err);

    final refreshToken = await StorageService.getRefreshToken();
    if (refreshToken == null) {
      _handleLogout();
      return handler.next(err);
    }

    try {
      final response = await Dio().post(
        '${_dio.options.baseUrl}/auth/refresh',
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );

      final newAccessToken = response.data['accessToken'];
      final newRefreshToken = response.data['refreshToken'];

      await StorageService.saveToken(
        access: newAccessToken,
        refresh: newRefreshToken,
      );

      err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

      final originResponse = await _dio.fetch(err.requestOptions);
      return handler.resolve(originResponse);
    } catch (e) {
      _handleLogout();
      return handler.next(err);
    }
  }

  void _handleLogout() {
    StorageService.clearAuthData();
  }
}
