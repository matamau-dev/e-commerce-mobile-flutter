import 'package:flutter/material.dart'
    show ChangeNotifier, FocusNode, FormState, GlobalKey, TextEditingController;

class LoginViewModel extends ChangeNotifier {
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode loginFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    loginFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? validateLogin(String? value) {
    if (value == null || value.isEmpty) return "Campo requerido";
    if (value.contains("@")) {
      return validateEmail(value);
    } else {
      return validateUsername(value);
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email requerido';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Email inválido';
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Usuario requerido';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Contraseña requerida';
    if (value.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  Future<bool> onFormSubmit() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
    // Return true to indicate success
    return true;
  }
}
