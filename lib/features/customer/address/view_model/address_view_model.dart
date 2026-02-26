import 'package:e_commerce/features/customer/address/model/address_model.dart';
import 'package:flutter/material.dart';

class AddressViewModel extends ChangeNotifier {
  List<AddressModel> _addresses = [
    const AddressModel(
      id: "1",
      name: "Casa",
      street: "Av. Reforma",
      exteriorNumber: "123",
      interiorNumber: "A",
      city: "CDMX",
      state: "CDMX",
      zipCode: "06600",
      isDefault: true,
    ),
    const AddressModel(
      id: "2",
      name: "Oficina",
      street: "Insurgentes Sur",
      exteriorNumber: "456",
      city: "CDMX",
      state: "CDMX",
      zipCode: "03100",
      isDefault: false,
    ),
  ];

  List<AddressModel> get addresses => _addresses;

  void addAddress(AddressModel address) {
    if (address.isDefault) {
      _setAllInactive();
    }
    if (_addresses.isEmpty) {
      _addresses.add(address.copyWith(isDefault: true));
    } else {
      _addresses.add(address);
    }
    notifyListeners();
  }

  void updateAddress(AddressModel updatedAddress) {
    if (updatedAddress.isDefault) {
      _setAllInactive();
    }
    final index = _addresses.indexWhere((a) => a.id == updatedAddress.id);
    if (index != -1) {
      _addresses[index] = updatedAddress;
      notifyListeners();
    }
  }

  void removeAddress(String id) {
    _addresses.removeWhere((a) => a.id == id);
    if (_addresses.isNotEmpty && !_addresses.any((a) => a.isDefault)) {
      _addresses[0] = _addresses[0].copyWith(isDefault: true);
    }
    notifyListeners();
  }

  void setDefault(String id) {
    _setAllInactive();
    final index = _addresses.indexWhere((a) => a.id == id);
    if (index != -1) {
      _addresses[index] = _addresses[index].copyWith(isDefault: true);
      notifyListeners();
    }
  }

  void _setAllInactive() {
    _addresses = _addresses.map((a) => a.copyWith(isDefault: false)).toList();
  }
}
