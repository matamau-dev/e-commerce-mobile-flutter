import 'package:e_commerce/features/customer/profile/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String imageUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "imageUrl": imageUrl,
  };

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
    id: entity.id,
    name: entity.name,
    email: entity.email,
    phone: entity.phone,
    imageUrl: entity.imageUrl,
  );

  UserEntity toEntity() => UserEntity(
    id: id,
    name: name,
    email: email,
    phone: phone,
    imageUrl: imageUrl,
  );

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? imageUrl,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
