import 'package:flutter/material.dart';

class SuppliersCard extends StatelessWidget {
  final List<Widget> widget;
  const SuppliersCard({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: Column(children: widget),
    );
  }
}
