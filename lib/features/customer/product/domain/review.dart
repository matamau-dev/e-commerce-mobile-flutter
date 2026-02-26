class Review {
  final String id;
  final String userName;
  final String userId;
  final double rating;
  final String comment;
  final DateTime date;

  Review({
    required this.id,
    required this.userName,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.date,
  });
}
