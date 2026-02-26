import 'package:flutter/material.dart';

class ActivityProduct {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final double rating;
  final String? tagLabel;

  const ActivityProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.rating = 0.0,
    this.tagLabel,
  });
}

enum CouponStatus { available, used, expired }

class Coupon {
  final String code;
  final double discount; // Percentage or fixed amount could be handled here
  final String description;
  final DateTime expiryDate;
  final CouponStatus status;

  const Coupon({
    required this.code,
    required this.discount,
    required this.description,
    required this.expiryDate,
    required this.status,
  });

  bool get isExpired => DateTime.now().isAfter(expiryDate);

  Color get statusColor {
    switch (status) {
      case CouponStatus.available:
        return Colors.green;
      case CouponStatus.used:
        return Colors.grey;
      case CouponStatus.expired:
        return Colors.red;
    }
  }

  String get formattedExpiry =>
      "${expiryDate.day}/${expiryDate.month}/${expiryDate.year}";
}
