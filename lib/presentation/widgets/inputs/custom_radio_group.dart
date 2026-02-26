import 'package:flutter/material.dart';

class CustomRadioGroup<T> extends StatelessWidget {
  final T? groupValue;
  final void Function(T?)? onChanged;
  final Map<T, String> options;
  final String? label;
  final String? Function(T?)? validator;
  const CustomRadioGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.options,
    this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormField<T>(
      initialValue: groupValue,
      validator: validator,
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 4),
                child: Text(
                  label!,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ...options.entries.map((entry) {
              return RadioListTile<T>(
                title: Text(entry.value),
                value: entry.key,
                groupValue: state.value,
                onChanged: (T? newValue) {
                  state.didChange(newValue);
                  if (onChanged != null) {
                    onChanged!(newValue);
                  }
                },
                contentPadding: EdgeInsets.zero,
                dense: true,
                activeColor: theme.primaryColor,
                controlAffinity: ListTileControlAffinity.leading,
              );
            }),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                child: Text(
                  state.errorText ?? 'Error',
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
