import 'package:dio/dio.dart';
import 'package:e_commerce/features/http/api_client.dart';
import 'package:e_commerce/features/utils/error_handler.dart';

class UserService {
  final Dio _dio = ApiClient.dio;

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await _dio.get('/users/profile');
      final data = response.data;
      return data;
    } on DioException catch (e) {
      throw ErrorHandler.fromDio(e);
    } catch (e) {
      throw Exception("Error al obtener el perfil del usuario");
    }
  }
}
