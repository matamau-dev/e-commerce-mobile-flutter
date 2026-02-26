import 'package:flutter/material.dart';

class RatingDisplay extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color? color;

  const RatingDisplay({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 14,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        IconData icon;
        if (index < rating.floor()) {
          icon = Icons.star;
        } else if (index < rating && (rating - index) >= 0.5) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }

        return Icon(icon, size: size, color: color ?? Colors.amber);
      }),
    );
  }
}
