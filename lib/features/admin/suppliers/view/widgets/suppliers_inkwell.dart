import 'package:e_commerce/features/admin/suppliers/view/widgets/suppliers_column.dart';
import 'package:e_commerce/presentation/images/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuppliersInkwell extends StatelessWidget {
  final ColorScheme colors;
  final int index;
  const SuppliersInkwell({
    super.key,
    required this.colors,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/supplier-details'),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CustomNetworkImage(
              imageURL: "https://i.pravatar.cc/150?img=${index + 11}",
              height: 56,
              width: 56,
              borderRadius: 12,
              boxFit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SuppliersColumn(colors: colors, index: index),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colors.primary.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
