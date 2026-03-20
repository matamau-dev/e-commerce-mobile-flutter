import 'package:e_commerce/features/admin/category/models/attribute_type.dart';
import 'package:e_commerce/features/admin/category/models/category_attribute.dart';

class CategorySchemaService {
  bool isAttributeComplete(CategoryAttribute config) {
    if (config.name.isEmpty) return false;

    // Lógica de Backend: Si es selección, debe tener opciones
    if (_isSelectorType(config.type)) {
      return config.options.isNotEmpty;
    }
    return true;
  }

  bool _isSelectorType(AttributeType type) {
    return [
      AttributeType.select,
      AttributeType.multiSelect,
      AttributeType.radio,
    ].contains(type);
  }

  List<CategoryAttribute> mergeWithParent(
    List<CategoryAttribute> parentAttrs,
    List<CategoryAttribute> localAttrs,
  ) {
    return [...parentAttrs, ...localAttrs];
  }
}
