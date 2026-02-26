import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _mockItems = [
    {
      "id": 1,
      "title": "Samsung Galaxy S24 Ultra",
      "price": 1200.00,
      "qty": 1,
      "img":
          "https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?auto=format&fit=crop&w=100&q=80",
    },
    {
      "id": 2,
      "title": "AirPods Pro 2nd Gen",
      "price": 249.00,
      "qty": 2,
      "img":
          "https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?auto=format&fit=crop&w=100&q=80",
    },
    {
      "id": 3,
      "title": "PlayStation 5 Slim",
      "price": 499.00,
      "qty": 1,
      "img":
          "https://images.unsplash.com/photo-1606813907291-d86efa9b94db?auto=format&fit=crop&w=100&q=80",
    },
  ];

  List<Map<String, dynamic>> get items => _mockItems;

  double get subtotal =>
      _mockItems.fold(0, (sum, item) => sum + (item["price"] * item["qty"]));
  double get shipping => subtotal > 2000 ? 0.0 : 50.0;
  double get tax => subtotal * 0.16;
  double get total => subtotal + shipping + tax;
  bool get isEmpty => _mockItems.isEmpty;

  void incrementQuantity(int index) {
    _mockItems[index]["qty"]++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_mockItems[index]["qty"] > 1) {
      _mockItems[index]["qty"]--;
      notifyListeners();
    }
  }

  void removeItem(int index) {
    _mockItems.removeAt(index);
    notifyListeners();
  }

  void addToCart(Map<String, dynamic> product, int quantity) {
    final index = _mockItems.indexWhere((item) => item["id"] == product["id"]);
    if (index != -1) {
      _mockItems[index]["qty"] += quantity;
    } else {
      _mockItems.add({
        "id": product["id"],
        "title": product["title"],
        "price": product["price"],
        "qty": quantity,
        "img": product["img"],
      });
    }
    notifyListeners();
  }

  void clearCart() {
    _mockItems.clear();
    notifyListeners();
  }
}
