import 'package:e_commerce/features/auth/login/domain/valueObject/login_email.dart';
import 'package:e_commerce/features/auth/login/domain/valueObject/login_password.dart';

class LoginEntity {
  final LoginEmail email;
  final LoginPassword password;
  final String deviceInfo;
  final String ipAddress;

  LoginEntity({
    required this.email,
    required this.password,
    required this.deviceInfo,
    required this.ipAddress,
  });
}
