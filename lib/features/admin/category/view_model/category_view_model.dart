import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final List<String> _categories = ["Category 1", "Category 2", "Category 3"];
  final List<String> _subCategories = [
    "Sub Category 1",
    "Sub Category 2",
    "Sub Category 3",
  ];

  List<String> get categories => _categories;
  List<String> get subCategories => _subCategories;

  void addCategory(String name) {
    _categories.add(name);
    notifyListeners();
  }

  void addSubCategory(String name) {
    _subCategories.add(name);
    notifyListeners();
  }

  void deleteCategory(String name) {
    _categories.remove(name);
    notifyListeners();
  }

  void deleteSubCategory(String name) {
    _subCategories.remove(name);
    notifyListeners();
  }

  void editCategory(String name, String newName) {
    _categories[_categories.indexOf(name)] = newName;
    notifyListeners();
  }

  void editSubCategory(String name, String newName) {
    _subCategories[_subCategories.indexOf(name)] = newName;
    notifyListeners();
  }
}
