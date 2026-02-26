import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final Color? color;

  const RatingBar({
    super.key,
    required this.rating,
    this.size = 18.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final starColor = color ?? Colors.amber;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        int starPosition = index + 1;

        IconData iconData;

        if (rating >= starPosition) {
          iconData = Icons.star;
        } else if (rating > (starPosition - 1.0)) {
          iconData = Icons.star_half;
        } else {
          iconData = Icons.star_border;
        }

        return Icon(iconData, color: starColor, size: size);
      }),
    );
  }
}
