import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/widgets/cards/product_card.dart';

class ProductMock {
  final String title;
  final double price;
  final String image;
  ProductMock(this.title, this.price, this.image);
}

class RelatedProductsList extends StatelessWidget {
  const RelatedProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final products = List.generate(
      5,
      (index) => ProductMock(
        "Producto Relacionado $index",
        100.0 + (index * 20),
        "https://picsum.photos/seed/rel$index/200/300",
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "También te podría gustar",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 280,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final product = products[index];

              return SizedBox(
                width: 160,
                child: ProductCard(
                  title: product.title,
                  price: product.price,
                  imageUrl: product.image,
                  onTap: () {
                    print("Ir al producto ${product.title}");
                  },
                  onAdd: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
