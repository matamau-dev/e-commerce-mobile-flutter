import 'package:flutter/material.dart';

class QuickActionsPanel extends StatelessWidget {
  final VoidCallback onProduct;
  final VoidCallback onScan;
  final VoidCallback onCoupon;
  final VoidCallback onStock;

  const QuickActionsPanel({
    super.key,
    required this.onProduct,
    required this.onScan,
    required this.onCoupon,
    required this.onStock,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            "Acciones Rápidas",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ActionButton(
              label: "Producto",
              icon: Icons.add_box_outlined,
              color: Theme.of(context).colorScheme.primary,
              onTap: onProduct,
            ),
            _ActionButton(
              label: "Escanear",
              icon: Icons.qr_code_scanner,
              color: Theme.of(context).colorScheme.secondary,
              onTap: onScan,
            ),
            _ActionButton(
              label: "Cupón",
              icon: Icons.confirmation_number_outlined,
              color: Theme.of(context).colorScheme.tertiary,
              onTap: onCoupon,
            ),
            _ActionButton(
              label: "Stock",
              icon: Icons.inventory_2_outlined,
              color: Theme.of(context).colorScheme.primaryContainer,
              onTap: onStock,
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
