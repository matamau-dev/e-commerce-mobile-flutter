import 'package:flutter/material.dart';

class AddProductLineDialog extends StatefulWidget {
  final List<String> brands;

  const AddProductLineDialog({super.key, required this.brands});

  @override
  State<AddProductLineDialog> createState() => _AddProductLineDialogState();
}

class _AddProductLineDialogState extends State<AddProductLineDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String? _selectedBrand;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "name": _nameController.text.trim(),
        "brand": _selectedBrand,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Nueva Línea de Producto"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nombre del Modelo (ej: iPhone 12)",
                prefixIcon: const Icon(Icons.inventory_2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (val) =>
                  val == null || val.isEmpty ? "Escribe un nombre" : null,
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _selectedBrand,
              decoration: InputDecoration(
                labelText: "Selecciona la Marca",
                prefixIcon: const Icon(Icons.branding_watermark),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              items: widget.brands.map((brand) {
                return DropdownMenuItem(value: brand, child: Text(brand));
              }).toList(),
              onChanged: (val) => setState(() => _selectedBrand = val),
              validator: (val) => val == null ? "Selecciona una marca" : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(onPressed: _submit, child: const Text("Guardar")),
      ],
    );
  }
}
