import 'package:e_commerce/features/auth/register/data/models/register_model.dart';
import 'package:e_commerce/features/auth/register/data/service/register_service.dart';
import 'package:e_commerce/features/auth/register/domain/entities/user_registration.dart';
import 'package:e_commerce/features/auth/register/utils/register_validators.dart';
import 'package:e_commerce/features/exceptions/api_exception.dart';
import 'package:e_commerce/features/models/process_result.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier with RegisterValidators {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegisterService _registerService = RegisterService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  String get confirmPasswordMatchText => passwordController.text;

  @override
  void dispose() {
    nameController.dispose();
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

  Future<ProcessResult> onFormSubmit() async {
    final form = formKey.currentState;

    if (form == null || !form.validate()) {
      return ProcessResult.failure("Por favor, revisa los campos marcados.");
    }

    final entity = UserRegistration(
      fullName: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text,
    );

    _isLoading = true;
    notifyListeners();

    try {
      final registerData = RegisterModel.fromEntity(entity);
      await _registerService.postRegister(registerData.toJson());
      return ProcessResult.ok();
    } on ApiException catch (e) {
      return ProcessResult.failure(e.message);
    } catch (e) {
      debugPrint("Error en ViewModel: $e");
      return ProcessResult.failure(
        "Ocurrió un error inesperado en el sistema.",
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
