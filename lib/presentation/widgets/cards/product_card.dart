import 'package:e_commerce/presentation/images/custom_network_image.dart';
import 'package:flutter/material.dart';

import '../prices/price_tag.dart';
import '../feedback/rating_bar.dart';
import '../feedback/custom_chip.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final double? originalPrice;
  final double rating;
  final String imageUrl;
  final String? tagLabel;
  final VoidCallback? onAdd;
  final VoidCallback? onTap;
  final Widget? actionWidget;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.rating = 0.0,
    this.originalPrice,
    this.tagLabel,
    this.onAdd,
    this.onTap,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomNetworkImage(
                    imageURL: imageUrl,
                    height: double.infinity,
                    width: double.infinity,
                    boxFit: BoxFit.cover,
                  ),
                  if (tagLabel != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CustomChip(
                        label: tagLabel!,
                        color: theme.colorScheme.error,
                      ),
                    ),
                ],
              ),
            ),

            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),

                        if (rating > 0) RatingBar(rating: rating, size: 12),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: PriceTag(
                            price: price,
                            originalPrice: originalPrice,
                          ),
                        ),
                        if (actionWidget != null) ...[
                          const SizedBox(width: 4),
                          actionWidget!,
                        ] else if (onAdd != null) ...[
                          const SizedBox(width: 4),
                          Material(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: onAdd,
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  Icons.add_shopping_cart_rounded,
                                  color: theme.colorScheme.onPrimary,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
