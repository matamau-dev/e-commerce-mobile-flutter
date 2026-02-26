import 'package:e_commerce/features/customer/product/view/widgets/related_products_list.dart';
import 'package:e_commerce/presentation/images/custom_network_image.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'widgets/product_faq.dart';
import 'widgets/product_reviews.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_chip.dart';
import 'package:e_commerce/presentation/widgets/prices/price_text.dart';
import 'package:e_commerce/presentation/widgets/text/section_header.dart';
import 'widgets/product_bottom_action.dart';

import 'package:e_commerce/features/customer/product/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch ViewModel for changes
    final viewModel = context.watch<ProductViewModel>();
    final product = viewModel.product;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const CustomAppBar(title: "Detalles"),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 350,
                width: double.infinity,
                color: Colors.grey[50],
                child: CustomNetworkImage(
                  imageURL: product.imageUrl,
                  boxFit: BoxFit.contain,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleAndPrice(context, viewModel),

                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8.0,
                      children: ["Electrónica", "Samsung", "Android"].map((
                        category,
                      ) {
                        return CustomChip(
                          label: category,
                          onPressed: () {
                            print("Navegar a $category");
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 24),

                    const SectionHeader(title: "Descripción"),
                    const SizedBox(height: 12),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec metus vel metus feugiat feugiat. Nullam nec metus vel metus feugiat feugiat.",
                      style: TextStyle(color: Colors.grey[600], height: 1.5),
                    ),

                    const SizedBox(height: 24),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 24),

                    const ProductFAQ(),

                    const SizedBox(height: 24),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 24),

                    const ProductReviews(),
                  ],
                ),
              ),
              const RelatedProductsList(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      bottomNavigationBar: ProductBottomAction(
        onAdd: () {
          viewModel.addToCart();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Producto agregado al carrito")),
          );
        },
      ),
    );
  }

  Widget _buildTitleAndPrice(BuildContext context, ProductViewModel viewModel) {
    final product = viewModel.product;
    final isFavorite = viewModel.isFavorite;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            IconButton(
              onPressed: () => viewModel.toggleFavorite(),
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite
                    ? Colors.red
                    : Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        PriceText(
          price: product.price,
          originalPrice: product.price * 1.2,
          currencySymbol: '\$',
        ),
      ],
    );
  }
}
