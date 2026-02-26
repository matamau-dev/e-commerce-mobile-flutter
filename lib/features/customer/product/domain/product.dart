class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String? tagLabel;
  final String category;
  final double rating;
  final DateTime? dateAdded;

  Product(
    this.id,
    this.title,
    this.price,
    this.imageUrl,
    this.tagLabel, {
    this.category = 'General',
    this.rating = 4.5,
    this.dateAdded,
  });
}
