class AddressModel {
  final String id;
  final String name; // e.g. "Casa", "Trabajo"
  final String street;
  final String exteriorNumber;
  final String? interiorNumber;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.name,
    required this.street,
    required this.exteriorNumber,
    this.interiorNumber,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.isDefault,
  });

  String get fullAddress =>
      "$street $exteriorNumber ${interiorNumber != null ? 'Int $interiorNumber' : ''}, $city, $state, CP $zipCode";

  AddressModel copyWith({
    String? id,
    String? name,
    String? street,
    String? exteriorNumber,
    String? interiorNumber,
    String? city,
    String? state,
    String? zipCode,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      street: street ?? this.street,
      exteriorNumber: exteriorNumber ?? this.exteriorNumber,
      interiorNumber: interiorNumber ?? this.interiorNumber,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
