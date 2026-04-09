import 'package:dio/dio.dart';
import 'package:e_commerce/features/http/api_client.dart';
import 'package:e_commerce/features/utils/error_handler.dart';
import 'package:e_commerce/features/utils/storage_service.dart';

class LoginService {
  final Dio _dio = ApiClient.dio;

  Future<void> postLogin(Map<String, dynamic> loginData) async {
    try {
      final response = await _dio.post('/auth/login', data: loginData);
      final data = response.data;
      await StorageService.saveToken(
        access: data['accessToken'],
        refresh: data['refreshToken'],
      );
    } on DioException catch (e) {
      throw ErrorHandler.fromDio(e);
    } catch (e) {
      throw Exception("Error inesperado en el sistema");
    }
  }
}
