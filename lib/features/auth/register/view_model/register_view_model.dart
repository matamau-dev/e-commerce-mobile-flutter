import 'package:e_commerce/features/auth/register/data/models/register_model.dart';
import 'package:e_commerce/features/auth/register/data/service/register_service.dart';
import 'package:e_commerce/features/auth/register/domain/entities/user_registration.dart';
import 'package:e_commerce/features/auth/register/utils/register_validators.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier with RegisterValidators {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegisterService _registerService = RegisterService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RegisterViewModel() {
    nameController.addListener(notifyListeners);
    usernameController.addListener(notifyListeners);
    emailController.addListener(notifyListeners);
    phoneController.addListener(notifyListeners);
    passwordController.addListener(notifyListeners);
    confirmPasswordController.addListener(notifyListeners);
  }

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    nameFocusNode.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool get isFormValid {
    return nameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        validateName(nameController.text) == null &&
        validateUsername(usernameController.text) == null &&
        validateEmail(emailController.text) == null &&
        validatePhone(phoneController.text) == null &&
        validatePassword(passwordController.text) == null &&
        validateConfirmPassword(confirmPasswordController.text) == null;
  }

  @override
  String get confirmPasswordMatchText => passwordController.text;

  final bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  final bool _isConfirmPasswordVisible = false;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  // Validaciones movidas al mixin RegisterValidators

  Future<void> onFormSubmit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    final entity = UserRegistration(
      fullName: nameController.text,
      username: usernameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );
    
    _isLoading = true;
    notifyListeners();

    try {
      final registerData = RegisterModel.fromEntity(entity);
      await _registerService.postRegister(registerData.toJson());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
