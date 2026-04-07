import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:e_commerce/features/auth/login/data/model/login_model.dart';
import 'package:e_commerce/features/auth/login/data/service/login_service.dart';
import 'package:e_commerce/features/auth/login/domain/entities/login_entity.dart';
import 'package:e_commerce/features/auth/login/domain/valueObject/login_email.dart';
import 'package:e_commerce/features/auth/login/domain/valueObject/login_password.dart';
import 'package:e_commerce/features/exceptions/api_exception.dart';
import 'package:e_commerce/features/models/process_result.dart';
import 'package:flutter/material.dart'
    show ChangeNotifier, FocusNode, FormState, GlobalKey, TextEditingController;

class LoginViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final LoginService _loginService = LoginService();

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

  Future<ProcessResult> onFormSubmit() async {
    final form = formKeyLogin.currentState;
    if (form == null || !form.validate()) {
      return ProcessResult.failure("Por favor, revisa los campos marcados.");
    }
    final entity = LoginEntity(
      email: LoginEmail(loginController.text),
      password: LoginPassword(passwordController.text),
      deviceInfo: await getDeviceInfo(),
      ipAddress: await getIpAddress(),
    );
    _isLoading = true;
    notifyListeners();

    final loginData = LoginModel.fromEntity(entity);
    try {
      await _loginService.postLogin(loginData.toJson());
      return ProcessResult.ok();
    } on ApiException catch (e) {
      return ProcessResult.failure(e.message);
    } catch (e) {
      return ProcessResult.failure(
        "Ocurrió un error inesperado en el sistema.",
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return "${androidInfo.model}, Android ${androidInfo.version.release}";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return "${iosInfo.utsname.machine}, iOS ${iosInfo.systemVersion}";
    } else {
      return "Unknown Device";
    }
  }

  Future<String> getIpAddress() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
          return addr.address;
        }
      }
    }
    return "0.0.0.0";
  }
}
