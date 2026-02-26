import 'package:flutter/material.dart';

class CategoryFormDialog extends StatefulWidget {
  final String title;
  final String? initialName;
  final bool isSubCategory;
  final List<String>? categories;
  const CategoryFormDialog({
    super.key,
    required this.title,
    this.initialName,
    this.isSubCategory = false,
    this.categories,
  });

  @override
  State<CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<CategoryFormDialog> {
  late TextEditingController _controller;
  String? _selectedParent;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
    if (widget.categories != null && widget.categories!.isNotEmpty) {
      _selectedParent = widget.categories!.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nombre de la categoría",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            autofocus: true,
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Ej: Electrónica",
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.edit_note),
            ),
          ),
          if (widget.isSubCategory) ...[
            const SizedBox(height: 20),
            const Text(
              "Categoría Padre",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedParent,
                  isExpanded: true,
                  items: widget.categories?.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() => _selectedParent = newValue);
                  },
                ),
              ),
            ),
          ],
        ],
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
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
            Navigator.pop(context, {
              'name': _controller.text,
              'parent': _selectedParent,
            });
          },
          child: const Text("Guardar Cambios"),
        ),
      ],
    );
  }
}
