import 'package:e_commerce/features/customer/product/domain/product.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

class HomeViewModel extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HomeViewModel() {
    _loadProducts();
  }

  void _loadProducts() {
    _isLoading = true;
    notifyListeners();

    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final random = Random();
      final labels = ['NUEVO', 'DESTACADO', 'POPULAR', 'MEJOR VOTADO'];

      _products = List.generate(10, (index) {
        final String? randomLabel = random.nextDouble() < 0.5
            ? labels[random.nextInt(labels.length)]
            : null;

        return Product(
          "${index + 1}",
          "Producto $index",
          150.0 + (index * 10),
          "https://picsum.photos/id/${index + 50}/200/300",
          randomLabel,
        );
      });

      _isLoading = false;
      notifyListeners();
    });
  }

  void onProductSelected(BuildContext context, Product product) {
    context.push("/product", extra: product);
  }

  void onSearchChanged(String value) {
    // Implement search logic here if needed
  }

  void onNotificationPressed() {
    // Handle notification press
  }
}
