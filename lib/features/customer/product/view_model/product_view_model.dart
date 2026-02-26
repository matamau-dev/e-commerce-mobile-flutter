import 'package:e_commerce/features/customer/cart/view_model/cart_view_model.dart';
import 'package:e_commerce/features/customer/product/domain/review.dart';
import 'package:e_commerce/features/customer/profile/domain/models/activity_models.dart';
import 'package:e_commerce/features/customer/profile/view_model/activity_view_model.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  final ActivityViewModel _activityViewModel;
  final CartViewModel _cartViewModel;

  // Mock current product details
  // In a real app, this would be passed via constructor or loaded by ID
  final ActivityProduct _currentProduct = ActivityProduct(
    id: "101", // ID matches one of the mock items
    title: "Samsung Galaxy S24 Ultra",
    price: 1200.00,
    imageUrl: "https://picsum.photos/id/1/200/300", // Placeholder
    rating: 4.8,
  );

  ActivityProduct get product => _currentProduct;

  ProductViewModel(this._activityViewModel, this._cartViewModel);

  bool get isFavorite => _activityViewModel.isInWishlist(_currentProduct.id);

  void toggleFavorite() {
    _activityViewModel.toggleWishlist(_currentProduct);
    notifyListeners(); // Notify to rebuild UI (icon change)
  }

  // Mock reviews
  final List<Review> _reviews = [
    Review(
      id: "1",
      userName: "Mauricio Mátuz",
      userId: "u1",
      rating: 4.5,
      comment: "El producto llegó súper rápido. La calidad es increíble.",
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Review(
      id: "2",
      userName: "Ana García",
      userId: "u2",
      rating: 5.0,
      comment: "¡Me encanta! Definitivamente lo recomendaría.",
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  List<Review> get reviews => _reviews;

  void addReview(double rating, String comment) {
    if (rating == 0) return;

    final newReview = Review(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userName: "Usuario Actual", // In a real app, get from AuthService
      userId: "current_user",
      rating: rating,
      comment: comment,
      date: DateTime.now(),
    );

    _reviews.insert(0, newReview);
    notifyListeners();
  }

  void addToCart() {
    _cartViewModel.addToCart({
      "id": _currentProduct.id,
      "title": _currentProduct.title,
      "price": _currentProduct.price,
      "img": _currentProduct.imageUrl,
    }, 1);
  }
}
