import 'package:e_commerce/features/customer/profile/domain/models/activity_models.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:e_commerce/presentation/widgets/cards/product_card.dart';
import 'package:flutter/material.dart';

class ActivityProductsView extends StatelessWidget {
  final String title;
  final List<ActivityProduct> products;

  const ActivityProductsView({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.grid_off,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No hay productos en esta sección",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  title: product.title,
                  price: product.price,
                  imageUrl: product.imageUrl,
                  rating: product.rating,
                  tagLabel: product.tagLabel,
                  onTap: () {
                    // Navigate to product detail if needed
                  },
                  onAdd: () {
                    // Add to cart logic
                  },
                );
              },
            ),
    );
  }
}
