import 'package:flutter/material.dart';
import 'package:e_commerce/features/utils/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  bool _isLoading = true;

  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;
  String? get token => _token;

  AuthProvider();

  Future<void> checkAuth() async {
    print("DEBUG: Iniciando lectura de storage...");
    _isLoading = true;

    try {
      _token = await StorageService.getAccessToken().timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          print("DEBUG: El Storage tardó demasiado. Cancelando.");
          return null;
        },
      );
      print("DEBUG: Token obtenido: ${_token != null ? 'SI' : 'NO'}");
    } catch (e) {
      print("DEBUG: Error leyendo storage: $e");
      _token = null;
    } finally {
      _isLoading = false;
      notifyListeners();
      print("DEBUG: checkAuth finalizado.");
    }
  }

  void login(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    await StorageService.clearAuthData();
    notifyListeners();
  }
}
