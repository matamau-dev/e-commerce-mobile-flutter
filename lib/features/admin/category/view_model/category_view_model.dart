import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final List<String> _categories = ["Category 1", "Category 2", "Category 3"];
  final List<String> _subCategories = [
    "Sub Category 1",
    "Sub Category 2",
    "Sub Category 3",
  ];

  bool _isLoading = false;
  String? _errorMessage;

  List<String> get categories => _categories;
  List<String> get subCategories => _subCategories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> addCategory(String name) async {
    _setLoading(true);
    _setError(null);
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulando red
      _categories.add(name);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addSubCategory(String name) async {
    _setLoading(true);
    _setError(null);
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _subCategories.add(name);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteCategory(String name) async {
    _setLoading(true);
    _setError(null);
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _categories.remove(name);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteSubCategory(String name) async {
    _setLoading(true);
    _setError(null);
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _subCategories.remove(name);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> editCategory(String name, String newName) async {
    _setLoading(true);
    _setError(null);
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final index = _categories.indexOf(name);
      if (index != -1) {
        _categories[index] = newName;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> editSubCategory(String name, String newName) async {
    _setLoading(true);
    _setError(null);
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final index = _subCategories.indexOf(name);
      if (index != -1) {
        _subCategories[index] = newName;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}
