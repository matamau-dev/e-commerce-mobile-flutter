import 'package:e_commerce/features/customer/payment/domain/brand.dart';
import 'package:e_commerce/features/customer/payment/model/card_payment.dart';
import 'package:flutter/material.dart';

class PaymentsViewModel extends ChangeNotifier {
  // Mock Initial Data
  List<CardPayment> _cards = [
    const CardPayment(
      id: "1",
      cardHolderName: "Mauricio G.",
      last4: "4242",
      expMonth: "12",
      expYear: "29",
      brand: Brand.visa,
      active: true,
    ),
    const CardPayment(
      id: "2",
      cardHolderName: "Mauricio G.",
      last4: "8888",
      expMonth: "05",
      expYear: "30",
      brand: Brand.mastercard,
      active: false,
    ),
  ];

  List<CardPayment> get cards => _cards;

  void addCard(CardPayment newCard) {
    if (newCard.active) {
      _setAllInactive();
    }
    // If it's the first card, make it active by default
    if (_cards.isEmpty) {
      _cards.add(newCard.copyWith(active: true));
    } else {
      _cards.add(newCard);
    }
    notifyListeners();
  }

  void removeCard(String id) {
    _cards.removeWhere((card) => card.id == id);
    // If we removed the active card and there are others, make the first one active
    if (_cards.isNotEmpty && !_cards.any((c) => c.active)) {
      _cards[0] = _cards[0].copyWith(active: true);
    }
    notifyListeners();
  }

  void setDefault(String id) {
    _setAllInactive();
    final index = _cards.indexWhere((card) => card.id == id);
    if (index != -1) {
      _cards[index] = _cards[index].copyWith(active: true);
      notifyListeners();
    }
  }

  void updateCard(CardPayment updatedCard) {
    final index = _cards.indexWhere((c) => c.id == updatedCard.id);
    if (index != -1) {
      _cards[index] = updatedCard;
      notifyListeners();
    }
  }

  void _setAllInactive() {
    _cards = _cards.map((c) => c.copyWith(active: false)).toList();
  }
}
