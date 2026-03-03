import 'package:flutter/material.dart';

class ProductLineFilter extends StatelessWidget {
  final List<String> filters;
  const ProductLineFilter({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = false;
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];

          return ChoiceChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (selected) {
              // por ahora vacío si no quieres lógica
            },
            selectedColor: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.surface,
            labelStyle: TextStyle(
              color: isSelected
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
              ),
            ),
            showCheckmark: false,
          );
        },
      ),
    );
  }
}
