import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double? originalPrice;
  final TextStyle? style;
  final String currencySymbol;

  const PriceText({
    super.key,
    required this.price,
    this.originalPrice,
    this.style,
    this.currencySymbol = '\$',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (originalPrice != null && originalPrice! > price)
          Text(
            "$currencySymbol${originalPrice!.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        Text(
          "$currencySymbol${price.toStringAsFixed(2)}",
          style:
              style ??
              Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }
}
