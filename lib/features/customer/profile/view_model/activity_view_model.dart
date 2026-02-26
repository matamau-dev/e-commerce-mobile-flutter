import 'package:e_commerce/features/customer/profile/domain/models/activity_models.dart';
import 'package:flutter/material.dart';

class ActivityViewModel extends ChangeNotifier {
  // Mock Viewed History
  final List<ActivityProduct> _viewedProducts = [
    ActivityProduct(
      id: "101",
      title: "Smartphone X Pro",
      price: 999.0,
      imageUrl: "https://picsum.photos/id/1/200/300",
      rating: 4.8,
      tagLabel: "NUEVO",
    ),
    ActivityProduct(
      id: "102",
      title: "Auriculares Noise Cancelling",
      price: 250.0,
      imageUrl: "https://picsum.photos/id/2/200/300",
      rating: 4.5,
    ),
    ActivityProduct(
      id: "103",
      title: "Laptop Ultra Thin",
      price: 1500.0,
      imageUrl: "https://picsum.photos/id/3/200/300",
      rating: 4.9,
    ),
    ActivityProduct(
      id: "104",
      title: "Smartwatch Series 5",
      price: 350.0,
      imageUrl: "https://picsum.photos/id/4/200/300",
      rating: 4.2,
    ),
  ];

  // Mock Wishlist
  final List<ActivityProduct> _wishlistProducts = [
    ActivityProduct(
      id: "201",
      title: "Cámara DSLR 4K",
      price: 1200.0,
      imageUrl: "https://picsum.photos/id/5/200/300",
      rating: 4.7,
      tagLabel: "OFERTA",
    ),
    ActivityProduct(
      id: "202",
      title: "Consola de Videojuegos",
      price: 500.0,
      imageUrl: "https://picsum.photos/id/6/200/300",
      rating: 4.8,
    ),
  ];

  void toggleWishlist(ActivityProduct product) {
    final index = _wishlistProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _wishlistProducts.removeAt(index);
    } else {
      _wishlistProducts.add(product);
    }
    notifyListeners();
  }

  bool isInWishlist(String productId) {
    return _wishlistProducts.any((p) => p.id == productId);
  }

  // Mock Coupons
  final List<Coupon> _coupons = [
    Coupon(
      code: "WELCOME20",
      discount: 20.0,
      description: "20% de descuento en tu primera compra",
      expiryDate: DateTime.now().add(const Duration(days: 30)),
      status: CouponStatus.available,
    ),
    Coupon(
      code: "SUMMER10",
      discount: 10.0,
      description: "10% de descuento en ropa de verano",
      expiryDate: DateTime.now().add(const Duration(days: 15)),
      status: CouponStatus.available,
    ),
    Coupon(
      code: "FREESHIP",
      discount: 0.0, // Represents free shipping
      description: "Envío gratis en compras mayores a \$50",
      expiryDate: DateTime.now().add(const Duration(days: 7)),
      status: CouponStatus.available,
    ),
    Coupon(
      code: "WINTER50",
      discount: 50.0,
      description: "\$50 pesos de descuento directo",
      expiryDate: DateTime.now().subtract(const Duration(days: 10)),
      status: CouponStatus.used,
    ),
    Coupon(
      code: "BLACKFRIDAY",
      discount: 30.0,
      description: "30% off Black Friday",
      expiryDate: DateTime.now().subtract(const Duration(days: 60)),
      status: CouponStatus.expired,
    ),
  ];

  List<ActivityProduct> get viewedProducts => _viewedProducts;
  List<ActivityProduct> get wishlistProducts => _wishlistProducts;

  List<Coupon> get availableCoupons =>
      _coupons.where((c) => c.status == CouponStatus.available).toList();
  List<Coupon> get usedCoupons => _coupons
      .where((c) => c.status == CouponStatus.used)
      .toList(); // Could also include expired if desired
}
