import 'package:flutter/material.dart';

class ProductLineViewModel extends ChangeNotifier {
  // En lugar de una clase, usamos una lista de mapas
  final List<Map<String, String>> _lines = [
    {"name": "iPhone 15", "brand": "Apple"},
    {"name": "Galaxy S24", "brand": "Samsung"},
  ];

  // Getter para que la View pueda leer la lista
  List<Map<String, String>> get lines => _lines;

  // AGREGAR
  void addLine(String name, String brandName) {
    if (name.isNotEmpty && brandName.isNotEmpty) {
      _lines.add({"name": name, "brand": brandName});
      notifyListeners();
    }
  }

  // ELIMINAR (usamos el índice porque no tenemos ID)
  void deleteLine(int index) {
    _lines.removeAt(index);
    notifyListeners();
  }

  // EDITAR
  void editLine(int index, String newName, String newBrand) {
    if (index >= 0 && index < _lines.length) {
      _lines[index] = {"name": newName, "brand": newBrand};
      notifyListeners();
    }
  }
}
