import 'package:e_commerce/features/admin/category/models/attribute_type.dart';
import 'package:e_commerce/features/admin/category/models/category_attribute.dart';
import 'package:flutter/material.dart';

class CategorySchemaEditorViewModel extends ChangeNotifier {
  List<CategoryAttribute> _attributes = [];
  List<CategoryAttribute> get attributes => _attributes;

  void addEmptyAttribute() {
    _attributes.add(
      CategoryAttribute(
        name: "",
        description: "",
        type: AttributeType.text,
        icon: Icons.label_outline,
        isRequired: false,
        options: [],
      ),
    );
    notifyListeners();
  }

  // ESTA ES LA FUNCIÓN CLAVE: Guarda cualquier cambio en el atributo
  void updateAttribute(CategoryAttribute updatedAttribute, int index) {
    if (index >= 0 && index < _attributes.length) {
      _attributes[index] = updatedAttribute;
      notifyListeners(); // Esto refresca la UI
    }
  }

  void removeAttribute(int index) {
    _attributes.removeAt(index);
    notifyListeners();
  }
}
