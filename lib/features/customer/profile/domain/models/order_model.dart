import 'package:flutter/material.dart';

enum OrderStatus {
  pending,
  paid,
  processing,
  shipped,
  delivered,
  cancelled,
  returned;

  String get label {
    switch (this) {
      case OrderStatus.pending:
        return "Pendiente de pago";
      case OrderStatus.paid:
        return "Pagado";
      case OrderStatus.processing:
        return "Procesando";
      case OrderStatus.shipped:
        return "En enviado";
      case OrderStatus.delivered:
        return "Entregado";
      case OrderStatus.cancelled:
        return "Cancelado";
      case OrderStatus.returned:
        return "Devuelto";
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.paid:
        return Colors.blue;
      case OrderStatus.processing:
        return Colors.blueAccent;
      case OrderStatus.shipped:
        return Colors.indigo;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.returned:
        return Colors.purple;
    }
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;
}

class OrderModel {
  final String id;
  final DateTime date;
  final OrderStatus status;
  final double total;
  final int itemCount;
  final String trackingNumber;
  final String? firstProductImage;
  final List<OrderItem> items;
  // In a real app, this would be an AddressModel, but for simplicity we'll use a String for now or just mock it in UI
  final String shippingAddress;

  const OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.itemCount,
    required this.trackingNumber,
    this.firstProductImage,
    required this.items,
    required this.shippingAddress,
  });

  String get formattedDate => "${date.day}/${date.month}/${date.year}";
}
