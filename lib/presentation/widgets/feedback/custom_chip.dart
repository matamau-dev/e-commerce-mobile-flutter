import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? textColor;
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomChip({
    super.key,
    required this.label,
    this.color,
    this.textColor,
    this.isSelected = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = color ?? theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? baseColor : baseColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? null : Border.all(color: baseColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? (textColor ?? Colors.white) : baseColor,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
