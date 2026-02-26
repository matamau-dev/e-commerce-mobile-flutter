import 'package:e_commerce/features/customer/product/domain/product.dart';
import 'package:flutter/material.dart';
import '../cards/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Function(Product)? onProductTap;
  final bool isScrollable;

  const ProductGrid({
    super.key,
    required this.products,
    this.onProductTap,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: isScrollable,
      physics: isScrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          title: product.title,
          price: product.price,
          imageUrl: product.imageUrl,
          tagLabel: product.tagLabel,
          rating: 4.5,
          onTap: () {
            if (onProductTap != null) {
              onProductTap!(product);
            }
          },

          onAdd: () {
            print("Agregando ID ${product.id} al carrito");
          },
        );
      },
    );
  }
}
