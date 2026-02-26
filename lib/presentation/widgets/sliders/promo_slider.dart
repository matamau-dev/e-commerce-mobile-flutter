import 'package:e_commerce/presentation/images/custom_network_image.dart';
import 'package:flutter/material.dart';

class PromoSlider extends StatefulWidget {
  final List<String> images;
  final double height;
  final EdgeInsets? padding;

  const PromoSlider({
    super.key,
    required this.images,
    this.height = 200,
    this.padding,
  });

  @override
  State<PromoSlider> createState() => _PromoSliderState();
}

class _PromoSliderState extends State<PromoSlider> {

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            PageView.builder(
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return CustomNetworkImage(
                  imageURL: widget.images[index],
                  borderRadius: 12,
                  boxFit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),

            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.images.length, (index) {
                  final isActive = _currentPage == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 24 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: isActive
                          ? colors.secondary
                          : colors.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isActive
                            ? colors.secondary
                            : colors.onSurface.withAlpha(6),
                        width: 1.5,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
