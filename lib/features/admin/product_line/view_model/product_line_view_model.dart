import 'package:flutter/material.dart';

class ProductLineViewModel extends ChangeNotifier {
  final List<Map<String, String>> _lines = [
    {"name": "iPhone 15", "brand": "Apple"},
    {"name": "Galaxy S24", "brand": "Samsung"},
  ];

  List<Map<String, String>> get lines => _lines;

  void addLine(String name, String brandName) {
    if (name.isNotEmpty && brandName.isNotEmpty) {
      _lines.add({"name": name, "brand": brandName});
      notifyListeners();
    }
  }

  void deleteLine(int index) {
    _lines.removeAt(index);
    notifyListeners();
  }

  void editLine(int index, String newName, String newBrand) {
    if (index >= 0 && index < _lines.length) {
      _lines[index] = {"name": newName, "brand": newBrand};
      notifyListeners();
    }
  }
}
