import 'package:e_commerce/features/auth/register/domain/entities/user_registration.dart';

class RegisterModel {
  // Estos nombres coinciden EXACTAMENTE con tu JSON de la API
  final String name;
  final String email;
  final String phone;
  final String password;

  RegisterModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  // Mapper: De Entidad (Flutter) a Modelo (JSON para la API)
  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "password": password,
  };

  // Factory para crear el modelo desde la entidad
  factory RegisterModel.fromEntity(UserRegistration entity) => RegisterModel(
    name: entity.fullName,
    email: entity.email,
    phone: entity.phone,
    password: entity.password,
  );
}
