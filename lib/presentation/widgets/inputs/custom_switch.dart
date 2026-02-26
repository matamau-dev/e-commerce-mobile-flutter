import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;
  final String? Function(bool?)? validator;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: value,
      validator: validator,
      builder: (FormFieldState<bool> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              value: value,
              onChanged: (newValue) {
                state.didChange(newValue);
                onChanged(newValue);
              },
              title: Text(label),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
              activeThumbColor: Theme.of(context).primaryColor,
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 0),
                child: Text(
                  state.errorText ?? 'Error',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
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
