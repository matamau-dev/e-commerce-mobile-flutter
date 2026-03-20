import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddCategoryDialog extends StatefulWidget {
  final List<String> categories;

  const AddCategoryDialog({super.key, required this.categories});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final _nameFocus = FocusNode();
  final _dropdownFocus = FocusNode();

  bool _isSubCategory = false;
  String? _selectedParent;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "isSub": _isSubCategory,
        "name": _nameController.text.trim(),
        "parent": _isSubCategory ? _selectedParent : null,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Nueva Categoría"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: false,
                  label: Text('Categoría'),
                  icon: Icon(Icons.folder),
                ),
                ButtonSegment(
                  value: true,
                  label: Text('Subcategoría'),
                  icon: Icon(Icons.account_tree),
                ),
              ],
              selected: {_isSubCategory},
              onSelectionChanged: (val) =>
                  setState(() => _isSubCategory = val.first),
            ),
            const SizedBox(height: 20),

            CustomTextFormField(
              controller: _nameController,
              focusNode: _nameFocus,
              textInputAction: _isSubCategory
                  ? TextInputAction.next
                  : TextInputAction.done,
              label: "Nombre",
              prefixIcon: Icons.edit,
              validator: (val) =>
                  val == null || val.isEmpty ? "Campo obligatorio" : null,
              onSubmitted: (_) {
                if (_isSubCategory) {
                  FocusScope.of(context).requestFocus(_dropdownFocus);
                } else {
                  _submit();
                }
              },
            ),

            if (_isSubCategory) ...[
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                focusNode: _dropdownFocus,
                decoration: InputDecoration(
                  labelText: "Categoría Padre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: widget.categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => _selectedParent = val,
                validator: (val) => _isSubCategory && val == null
                    ? "Selecciona un padre"
                    : null,
              ),
            ],
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
