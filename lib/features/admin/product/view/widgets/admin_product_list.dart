import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/widgets/cards/product_list_tile.dart';

class AdminProductList extends StatelessWidget {
  const AdminProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 10,
      itemBuilder: (context, index) {
        final theme = Theme.of(context);

        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: ProductListTile(
            title: "iPhone 15",
            price: 999,
            imageUrl: "https://picsum.photos/id/4/200/300",
            subtitle: "Apple • 128GB",
            tags: const ["Electrónica", "Smartphone", "Stock: 2"],
            onTap: () {
              debugPrint("DETALLE PRODUCTO");
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  color: theme.colorScheme.primary,
                  onPressed: () {
                    debugPrint("Editar producto");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: theme.colorScheme.error,
                  onPressed: () {
                    debugPrint("Eliminar producto");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
