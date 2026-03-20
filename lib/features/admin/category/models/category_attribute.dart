import 'package:e_commerce/features/admin/category/models/attribute_type.dart';
import 'package:flutter/material.dart';

class CategoryAttribute {
  final String name;
  final String description;
  final AttributeType type;
  final IconData icon;
  final bool isRequired;
  final List<String> options;

  CategoryAttribute({
    required this.name,
    required this.description,
    required this.type,
    required this.icon,
    required this.isRequired,
    this.options = const [],
  });

  bool get isValid {
    if (type == AttributeType.select ||
        type == AttributeType.multiSelect ||
        type == AttributeType.radio) {
      return options.isNotEmpty;
    }
    return true;
  }

  String getTypeNameFromType(AttributeType type) {
    switch (type) {
      case AttributeType.text:
        return "Texto corto";
      case AttributeType.textarea:
        return "Descripción larga";
      case AttributeType.number:
        return "Número";
      case AttributeType.select:
        return "Lista de opciones";
      case AttributeType.multiSelect:
        return "Selección múltiple";
      case AttributeType.radio:
        return "Opción única";
      case AttributeType.toggle:
        return "Sí / No";
    }
  }

  CategoryAttribute copyWith({
    String? name,
    String? description,
    AttributeType? type,
    IconData? icon,
    bool? isRequired,
    List<String>? options,
  }) {
    return CategoryAttribute(
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      isRequired: isRequired ?? this.isRequired,
      options: options ?? this.options,
    );
  }
}
