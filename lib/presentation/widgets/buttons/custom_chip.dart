import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? labelColor;

  const CustomChip({
    super.key,
    required this.label,
    this.onPressed,
    this.isSelected = false,
    this.backgroundColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ActionChip(
      label: Text(label),
      onPressed: onPressed,
      backgroundColor:
          backgroundColor ??
          (isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceVariant),
      labelStyle: TextStyle(
        color:
            labelColor ??
            (isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant),
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
