import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double price;
  final double? originalPrice;
  final String currency;

  const PriceTag({
    super.key,
    required this.price,
    this.originalPrice,
    this.currency = '\$',
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount = originalPrice != null && originalPrice! > price;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (hasDiscount) ...[
          Text(
            _formatCurrency(originalPrice!),
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
        ],

        Text(
          _formatCurrency(price),
          style: TextStyle(
            color: Theme.of(
              context,
            ).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double price) {
    String priceString = price.toStringAsFixed(2);
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String mathFunc(Match match) => '${match[1]},';
    String result = priceString.replaceAllMapped(reg, mathFunc);

    return '$currency$result';
  }
}
