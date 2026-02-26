import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageURL;
  final double? height;
  final double? width;
  final double borderRadius;
  final BoxFit boxFit;

  const CustomNetworkImage({
    super.key,
    required this.imageURL,
    this.height,
    this.width,
    this.borderRadius = 0.0,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        height: height,
        width: width,
        child: CachedNetworkImage(
          imageUrl: imageURL,
          fit: boxFit,
          placeholder: (context, url) => Container(
            color: colors.onSurfaceVariant,
            child: const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: colors.onSurfaceVariant,
            alignment: Alignment.center,
            child: Icon(
              Icons.broken_image_rounded,
              color: colors.onSurfaceVariant.withAlpha(5),
              size: (height != null && height!.isFinite) ? height! * 0.4 : 30,
            ),
          ),
        ),
      ),
    );
  }
}
