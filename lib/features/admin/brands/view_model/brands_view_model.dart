import 'package:flutter/material.dart';

class BrandsViewModel extends ChangeNotifier {
  final List<String> _brands = [
    "Nike",
    "Adidas",
    "Puma",
    "Reebok",
    "New Balance",
    "Under Armour",
    "Asics",
    "Mizuno",
    "Salomon",
    "Brooks",
    "Hoka",
    "Saucony",
    "Skechers",
    "Vans",
    "Converse",
    "Puma",
    "Reebok",
    "New Balance",
    "Under Armour",
    "Asics",
    "Mizuno",
    "Salomon",
    "Brooks",
    "Hoka",
    "Saucony",
    "Skechers",
    "Vans",
    "Converse",
  ];

  List<String> get brands => _brands;

  void addBrand(String name) {
    _brands.add(name);
    notifyListeners();
  }

  void deleteBrand(String name) {
    _brands.remove(name);
    notifyListeners();
  }

  void editBrand(String oldName, String newName) {
    final index = _brands.indexOf(oldName);
    if (index != -1) {
      _brands[index] = newName;
      notifyListeners();
    }
  }
}
