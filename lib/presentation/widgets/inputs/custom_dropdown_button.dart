import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final String label;
  final void Function(T?)? onChanged;
  final String Function(T) itemAsString;
  final T? value;
  final String? hint;
  final String? errorMessage;
  final IconData? prefixIcon;
  final void Function()? onTap;
  final String? Function(T?)? validator;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.label,
    required this.itemAsString,
    this.value,
    this.hint,
    this.errorMessage,
    this.onChanged,
    this.onTap,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: items,
      initialValue: value,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
