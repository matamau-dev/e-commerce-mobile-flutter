import 'package:flutter/material.dart';

enum Brand {
  visa,
  mastercard,
  amex,
  other;

  static Brand fromNumber(String cardNumber) {
    if (cardNumber.isEmpty) return Brand.other;
    final number = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');


    if (RegExp(r'^4').hasMatch(number)) {
      return Brand.visa;
    }


    if (RegExp(r'^5[1-5]').hasMatch(number) || _isInRange(number, 2221, 2720)) {
      return Brand.mastercard;
    }


    if (RegExp(r'^3[47]').hasMatch(number)) {
      return Brand.amex;
    }

    return Brand.other;
  }

  static bool _isInRange(String number, int min, int max) {
    final length = min.toString().length;
    if (number.length < length) return false;
    final prefix = int.tryParse(number.substring(0, length));
    return prefix != null && prefix >= min && prefix <= max;
  }
}

extension BrandExtension on Brand {
  String get name {
    switch (this) {
      case Brand.visa:
        return 'Visa';
      case Brand.mastercard:
        return 'Mastercard';
      case Brand.amex:
        return 'American Express';
      case Brand.other:
        return 'Other';
    }
  }

  String get image {
    switch (this) {
      case Brand.visa:
        return 'assets/icons/brands/visa.svg';
      case Brand.mastercard:
        return 'assets/icons/brands/mastercard.svg';
      case Brand.amex:
        return 'assets/icons/brands/amex.svg';
      case Brand.other:
        return 'assets/icons/brands/other.svg';
    }
  }

  Color get color {
    switch (this) {
      case Brand.visa:
        return const Color(0xFF1A1F71);
      case Brand.mastercard:
        return const Color(0xFF222222);
      case Brand.amex:
        return const Color(0xFF007BC1);
      case Brand.other:
        return const Color(0xFF607D8B);
    }
  }
}
