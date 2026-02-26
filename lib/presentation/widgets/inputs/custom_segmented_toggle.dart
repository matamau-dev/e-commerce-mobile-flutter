import 'package:flutter/material.dart';

class CustomSegmentedToggle<T> extends StatelessWidget {
  final Set<T> selected;
  final void Function(Set<T>) onSelectionChanged;
  final Map<T, Widget> segments;
  final bool multiSelectionEnabled;
  final String? label;
  final bool emptySelectionAllowed;
  final String? Function(Set<T>?)? validator;

  const CustomSegmentedToggle({
    super.key,
    required this.selected,
    required this.onSelectionChanged,
    required this.segments,
    this.multiSelectionEnabled = false,
    this.label,
    this.emptySelectionAllowed = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FormField<Set<T>>(
      initialValue: selected,
      validator: validator,
      builder: (FormFieldState<Set<T>> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                child: Text(
                  label!,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            SegmentedButton<T>(
              segments: segments.entries.map((entry) {
                return ButtonSegment<T>(value: entry.key, label: entry.value);
              }).toList(),
              selected: selected,
              onSelectionChanged: (newSelection) {
                state.didChange(newSelection);
                onSelectionChanged(newSelection);
              },
              multiSelectionEnabled: multiSelectionEnabled,
              emptySelectionAllowed: emptySelectionAllowed,
              style: ButtonStyle(
                visualDensity: VisualDensity.comfortable,
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                side: state.hasError
                    ? WidgetStateProperty.all(
                        BorderSide(color: colorScheme.error),
                      )
                    : null,
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                child: Text(
                  state.errorText ?? '',
                  style: TextStyle(color: colorScheme.error, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
