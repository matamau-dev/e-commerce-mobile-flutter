import 'package:flutter/material.dart';

class SuppliersColumn extends StatelessWidget {
  final ColorScheme colors;
  final int index;
  const SuppliersColumn({super.key, required this.colors, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Distribuidora Global ${index + 1}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          'Proveedor de producto ${index + 1}',
          style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          '+52 55 1234 567${index + 1}',
          style: TextStyle(color: colors.onSurfaceVariant, fontSize: 10),
        ),
      ],
    );
  }
}
