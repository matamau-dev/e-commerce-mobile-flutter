import 'package:dio/dio.dart';
import 'package:e_commerce/features/http/api_client.dart';
import 'package:e_commerce/features/utils/error_handler.dart';

class LoginService {
  final Dio _dio = ApiClient.dio;

  Future<void> postLogin(Map<String, dynamic> loginData) async {
    try {
      final a = await _dio.post('/auth/login', data: loginData);
      print("Login response: ${a.data}");
    } on DioException catch (e) {
      throw ErrorHandler.fromDio(e);
    } catch (e) {
      throw Exception("Error inesperado en el sistema");
    }
  }
}
