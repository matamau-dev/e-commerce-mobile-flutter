import 'package:flutter/material.dart';

class AddBrandsDialog extends StatefulWidget {
  final List<String> brands;

  const AddBrandsDialog({super.key, required this.brands});

  @override
  State<AddBrandsDialog> createState() => _AddBrandsDialogState();
}

class _AddBrandsDialogState extends State<AddBrandsDialog> {
  final _formKeyBrands = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _brandFocus = FocusNode();

  void _submit() {
    if (_formKeyBrands.currentState!.validate()) {
      Navigator.pop(context, _brandController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Nueva Marca"),
      content: Form(
        key: _formKeyBrands,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _brandController,
              focusNode: _brandFocus,
              autofocus: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: "Nombre Marca",
                prefixIcon: const Icon(Icons.edit),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Campo obligatiorio" : null,
              onFieldSubmitted: (_) {
                if (_formKeyBrands.currentState!.validate()) {
                  Navigator.pop(context, _brandController.text.trim());
                }
                _submit();
              },
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
