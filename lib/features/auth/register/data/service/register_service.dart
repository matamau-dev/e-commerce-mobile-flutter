import 'package:dio/dio.dart';
import 'package:e_commerce/features/http/api_client.dart';
import 'package:flutter/rendering.dart';

class RegisterService {
  final Dio _dio = ApiClient.dio;

  Future<void> postRegister(Map<String, dynamic> registerData) async {
    try {
      debugPrint(registerData.toString());
      debugPrint('registerData.toString() arriba');
      final response = await _dio.post('/users/register', data: registerData);
      debugPrint(response.toString());
      if (response.statusCode == 201) {
        debugPrint("Usuario registrado exitosamente");
      }
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      if (e.response != null && e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          final message = data['message'];
          if (message is List) {
            throw Exception(message.join('\n'));
          } else {
            throw Exception(message.toString());
          }
        }
      }
      
      if (e.response?.statusCode == 400) {
        throw Exception("Error en la solicitud al servidor");
      }
      
      throw Exception("Error de conexión con el servidor");
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Error inesperado al registrar usuario");
    }
  }
}
