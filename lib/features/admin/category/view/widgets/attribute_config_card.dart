import 'package:e_commerce/features/admin/category/models/attribute_type.dart';
import 'package:e_commerce/features/admin/category/models/category_attribute.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AttributeConfigCard extends StatelessWidget {
  final CategoryAttribute attribute;
  final VoidCallback onDelete;
  final Function(CategoryAttribute)
  onAttributeChanged; // Cambio de nombre para claridad

  const AttributeConfigCard({
    super.key,
    required this.attribute,
    required this.onDelete,
    required this.onAttributeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(attribute.icon),
            title: CustomTextFormField(
              label: "Nombre del atributo",
              hint: "Ej: Talla, Color...",
              onChanged: (val) =>
                  onAttributeChanged(attribute.copyWith(name: val)),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onDelete,
            ),
          ),

          // Selector de Tipo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<AttributeType>(
              isExpanded: true,
              value: attribute.type,
              items: AttributeType.values.map((typeValue) {
                return DropdownMenuItem(
                  value: typeValue,
                  child: Text(attribute.getTypeNameFromType(typeValue)),
                );
              }).toList(),
              onChanged: (newType) {
                if (newType != null) {
                  onAttributeChanged(attribute.copyWith(type: newType));
                }
              },
            ),
          ),

          // Renderizado condicional de opciones
          if (attribute.type == AttributeType.select ||
              attribute.type == AttributeType.multiSelect)
            _OptionsEditor(
              attribute: attribute,
              onChanged: (newOptions) {
                // Enviamos el atributo con la nueva lista de opciones
                onAttributeChanged(attribute.copyWith(options: newOptions));
              },
            ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _OptionsEditor extends StatelessWidget {
  final CategoryAttribute attribute;
  final Function(List<String>) onChanged;

  const _OptionsEditor({required this.attribute, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Opciones añadidas:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          if (attribute.options.isEmpty)
            const Text(
              "No hay opciones",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

          ...attribute.options.map(
            (option) => Container(
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                dense: true,
                title: Text(option),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
                  onPressed: () {
                    final newList = List<String>.from(attribute.options)
                      ..remove(option);
                    onChanged(newList);
                  },
                ),
              ),
            ),
          ),

          OutlinedButton.icon(
            onPressed: () => _showAddDialog(context),
            icon: const Icon(Icons.add),
            label: const Text("Agregar valor"),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Nuevo valor"),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final newList = List<String>.from(attribute.options)
                  ..add(controller.text);
                onChanged(newList);
              }
              Navigator.pop(ctx);
            },
            child: const Text("Añadir"),
          ),
        ],
      ),
    );
  }
}
