import 'package:e_commerce/features/auth/login/domain/entities/login_entity.dart';
import 'package:e_commerce/features/auth/login/domain/valueObject/login_password.dart';
import 'package:e_commerce/features/utils/valueObject/email.dart';

class LoginModel {
  final String email;
  final String password;
  final String deviceInfo;
  final String ipAddress;

  LoginModel({
    required this.email,
    required this.password,
    required this.deviceInfo,
    required this.ipAddress,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "deviceInfo": deviceInfo,
    "ipAddress": ipAddress,
  };

  factory LoginModel.fromEntity(LoginEntity entity) => LoginModel(
    email: entity.email.value,
    password: entity.password.value,
    deviceInfo: entity.deviceInfo,
    ipAddress: entity.ipAddress,
  );

  LoginEntity toEntity() => LoginEntity(
    email: Email(email),
    password: LoginPassword(password),
    deviceInfo: deviceInfo,
    ipAddress: ipAddress,
  );
}
