import 'package:e_commerce/features/customer/product/view/widgets/add_review_sheet.dart';
import 'package:e_commerce/features/customer/product/view_model/product_view_model.dart';
import 'package:e_commerce/presentation/widgets/cards/review_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductViewModel>();
    final reviews = viewModel.reviews;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Opiniones (${reviews.length})",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => AddReviewSheet(
                    onSubmit: (rating, comment) {
                      viewModel.addReview(rating, comment);
                    },
                  ),
                );
              },
              child: const Text("Escribir reseña"),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (reviews.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text("Sé el primero en opinar sobre este producto."),
          )
        else
          ...reviews.map(
            (review) => Column(
              children: [
                ReviewCard(
                  userName: review.userName,
                  rating: review.rating,
                  date: review.date,
                  comment: review.comment,
                ),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFFFAFAFA)),
              ],
            ),
          ),
      ],
    );
  }
}
