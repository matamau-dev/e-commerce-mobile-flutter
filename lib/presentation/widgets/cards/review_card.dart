import 'package:e_commerce/presentation/widgets/feedback/rating_display.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String? userImageUrl;
  final double rating;
  final DateTime date;
  final String comment;

  const ReviewCard({
    super.key,
    required this.userName,
    this.userImageUrl,
    required this.rating,
    required this.date,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final timeAgo = DateTime.now().difference(date).inDays;
    final dateString = timeAgo == 0 ? "Hoy" : "Hace $timeAgo días";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              backgroundImage: userImageUrl != null
                  ? NetworkImage(userImageUrl!)
                  : null,
              child: userImageUrl == null
                  ? Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Row(
                    children: [
                      RatingDisplay(rating: rating, size: 14),
                      const SizedBox(width: 8),
                      Text(
                        dateString,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (comment.isNotEmpty)
          Text(
            comment,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}
