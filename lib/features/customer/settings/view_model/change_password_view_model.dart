import 'package:flutter/material.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  int _currentStep = 0;
  bool _isLoading = false;

  int get currentStep => _currentStep;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void nextStep() {
    if (!formKey.currentState!.validate()) return;

    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  Future<bool> onFormSubmit() async {
    if (!formKey.currentState!.validate()) return false;

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email requerido';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Email inválido';
    return null;
  }

  String? validateOtp(String? value) {
    if (value == null || value.isEmpty) return 'OTP requerido';
    if (value.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Contraseña requerida';
    if (value.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirmar contraseña';
    if (value != passwordController.text) return 'Las contraseñas no coinciden';
    return null;
  }
}
