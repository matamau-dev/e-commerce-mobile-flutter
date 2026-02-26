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
