import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/widgets/cards/product_card.dart';

class AdminProductGrid extends StatelessWidget {
  const AdminProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final theme = Theme.of(context);

        return ProductCard(
          title: "iPhone 15",
          price: 999,
          imageUrl: "https://picsum.photos/id/4/200/300",
          tagLabel: "Stock: 2",
          onTap: () {
            debugPrint("Detalle producto");
          },
          actionWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ), // Evita que el IconButton crezca demasiado internamente
                iconSize: 20,
                icon: const Icon(Icons.edit_outlined),
                color: theme.colorScheme.primary,
                onPressed: () {
                  debugPrint("Editar producto");
                },
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                iconSize: 20,
                icon: const Icon(Icons.delete_outline),
                color: theme.colorScheme.error,
                onPressed: () {
                  debugPrint("Eliminar producto");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
