import 'package:flutter/material.dart';

class BrandsFormDialog extends StatefulWidget {
  final String title;
  final String? initialName;
  const BrandsFormDialog({super.key, required this.title, this.initialName});

  @override
  State<BrandsFormDialog> createState() => _BrandsFormDialogState();
}

class _BrandsFormDialogState extends State<BrandsFormDialog> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Nueva Marca"),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Nombre de la marca",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _controller,
              autofocus: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: "Ej: Nike",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.edit_note),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Campo obligatiorio" : null,
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          onPressed: () {
            Navigator.pop(context, _controller.text);
          },
          child: const Text("Guardar Cambios"),
        ),
      ],
    );
  }
}
