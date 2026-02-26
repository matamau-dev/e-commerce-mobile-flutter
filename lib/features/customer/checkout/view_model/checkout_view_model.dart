import 'package:e_commerce/features/customer/address/model/address_model.dart';
import 'package:e_commerce/features/customer/address/view_model/address_view_model.dart';
import 'package:e_commerce/features/customer/cart/view_model/cart_view_model.dart';
import 'package:e_commerce/features/customer/payment/model/card_payment.dart';
import 'package:e_commerce/features/customer/payment/view_model/payments_view_model.dart';
import 'package:flutter/material.dart';

class CheckoutViewModel extends ChangeNotifier {
  final CartViewModel _cartViewModel;
  final AddressViewModel _addressViewModel;
  final PaymentsViewModel _paymentsViewModel;

  AddressModel? _selectedAddress;
  CardPayment? _selectedPaymentMethod;
  bool _isLoading = false;

  CheckoutViewModel(
    this._cartViewModel,
    this._addressViewModel,
    this._paymentsViewModel,
  ) {
    _initializeDefaults();
  }

  AddressModel? get selectedAddress => _selectedAddress;
  CardPayment? get selectedPaymentMethod => _selectedPaymentMethod;
  bool get isLoading => _isLoading;

  // Get totals from CartViewModel
  double get subtotal => _cartViewModel.subtotal;
  double get shipping => _cartViewModel.shipping;
  double get tax => _cartViewModel.tax;
  double get total => _cartViewModel.total;

  void refreshData() {
    _initializeDefaults();
  }

  void _initializeDefaults() {
    // Attempt to set defaults from other ViewModels
    if (_addressViewModel.addresses.isNotEmpty) {
      // If we already have a selection, ensure it still exists, otherwise reset
      if (_selectedAddress != null) {
        try {
          _addressViewModel.addresses.firstWhere(
            (a) => a.id == _selectedAddress!.id,
          );
        } catch (_) {
          _selectedAddress = null; // Selected address was removed
        }
      }

      if (_selectedAddress == null) {
        // Find default or use first
        try {
          _selectedAddress = _addressViewModel.addresses.firstWhere(
            (a) => a.isDefault,
          );
        } catch (_) {
          _selectedAddress = _addressViewModel.addresses.first;
        }
      }
    } else {
      _selectedAddress = null;
    }

    if (_paymentsViewModel.cards.isNotEmpty) {
      // Similar logic for cards
      if (_selectedPaymentMethod != null) {
        try {
          _paymentsViewModel.cards.firstWhere(
            (c) => c.id == _selectedPaymentMethod!.id,
          );
        } catch (_) {
          _selectedPaymentMethod = null;
        }
      }

      if (_selectedPaymentMethod == null) {
        // Find default or use first
        try {
          _selectedPaymentMethod = _paymentsViewModel.cards.firstWhere(
            (c) => c.active,
          );
        } catch (_) {
          _selectedPaymentMethod = _paymentsViewModel.cards.first;
        }
      }
    } else {
      _selectedPaymentMethod = null;
    }
    notifyListeners();
  }

  void selectAddress(AddressModel address) {
    _selectedAddress = address;
    notifyListeners();
  }

  void selectPaymentMethod(CardPayment card) {
    _selectedPaymentMethod = card;
    notifyListeners();
  }

  Future<bool> placeOrder() async {
    if (_selectedAddress == null || _selectedPaymentMethod == null) {
      return false; // Validation failed
    }

    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Success logic
    _cartViewModel.clearCart(); // Example: clear cart after successful order
    _isLoading = false;
    notifyListeners();
    return true;
  }
}
