import 'package:flutter/material.dart';
import 'package:e_commerce/features/admin/product_line/view/widget/product_line_list_tile.dart';

class ProductLineCard extends StatelessWidget {
  final Map<String, String> line;
  const ProductLineCard({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ProductLineListTile(line: line),
    );
  }
}
