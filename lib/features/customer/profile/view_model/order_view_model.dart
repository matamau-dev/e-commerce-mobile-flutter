import 'package:e_commerce/features/customer/profile/domain/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderViewModel extends ChangeNotifier {
  final List<OrderModel> _allOrders = [
    OrderModel(
      id: "ORD-99281",
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: OrderStatus.shipped,
      total: 1250.00,
      itemCount: 3,
      trackingNumber: "TRK-88123991",
      firstProductImage: "https://via.placeholder.com/150",
      shippingAddress: "Av. Reforma 123, CDMX",
      items: [
        OrderItem(
          productId: "1",
          productName: "Producto A",
          productImage: "https://via.placeholder.com/150",
          price: 500.0,
          quantity: 1,
        ),
        OrderItem(
          productId: "2",
          productName: "Producto B",
          productImage: "https://via.placeholder.com/150",
          price: 375.0,
          quantity: 2,
        ),
      ],
    ),
    OrderModel(
      id: "ORD-99200",
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: OrderStatus.processing,
      total: 550.50,
      itemCount: 1,
      trackingNumber: "N/A",
      firstProductImage: "https://via.placeholder.com/150",
      shippingAddress: "Insurgentes Sur 456, CDMX",
      items: [
        OrderItem(
          productId: "3",
          productName: "Producto C",
          productImage: "https://via.placeholder.com/150",
          price: 550.50,
          quantity: 1,
        ),
      ],
    ),
    OrderModel(
      id: "ORD-88123",
      date: DateTime.now().subtract(const Duration(days: 15)),
      status: OrderStatus.delivered,
      total: 2100.00,
      itemCount: 4,
      trackingNumber: "TRK-77123123",
      firstProductImage: "https://via.placeholder.com/150",
      shippingAddress: "Calle 10, Merida",
      items: [
        OrderItem(
          productId: "4",
          productName: "Producto D",
          productImage: "https://via.placeholder.com/150",
          price: 525.0,
          quantity: 4,
        ),
      ],
    ),
    OrderModel(
      id: "ORD-11002",
      date: DateTime.now().subtract(const Duration(days: 20)),
      status: OrderStatus.cancelled,
      total: 120.00,
      itemCount: 1,
      trackingNumber: "N/A",
      firstProductImage: "https://via.placeholder.com/150",
      shippingAddress: "Av. Reforma 123, CDMX",
      items: [
        OrderItem(
          productId: "5",
          productName: "Producto E",
          productImage: "https://via.placeholder.com/150",
          price: 120.0,
          quantity: 1,
        ),
      ],
    ),
    OrderModel(
      id: "ORD-77123",
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: OrderStatus.pending,
      total: 899.00,
      itemCount: 2,
      trackingNumber: "N/A",
      firstProductImage: "https://via.placeholder.com/150",
      shippingAddress: "Av. Reforma 123, CDMX",
      items: [
        OrderItem(
          productId: "6",
          productName: "Producto F",
          productImage: "https://via.placeholder.com/150",
          price: 449.50,
          quantity: 2,
        ),
      ],
    ),
  ];

  List<OrderModel> getOrders({List<OrderStatus>? filterStatuses}) {
    if (filterStatuses == null || filterStatuses.isEmpty) {
      return _allOrders;
    }
    return _allOrders
        .where((order) => filterStatuses.contains(order.status))
        .toList();
  }
}
