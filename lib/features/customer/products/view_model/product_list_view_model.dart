import 'package:e_commerce/features/customer/product/domain/product.dart';

import 'package:flutter/material.dart';

enum SortOption { priceLowToHigh, priceHighToLow, newest }

class ProductListViewModel extends ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedCategory = 'Todos';
  RangeValues _priceRange = const RangeValues(0, 5000);
  SortOption _selectedSort = SortOption.newest;

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  RangeValues get priceRange => _priceRange;
  SortOption get selectedSort => _selectedSort;

  ProductListViewModel(String initialCategory) {
    if (initialCategory != 'Sin categoría') {
      _selectedCategory = initialCategory;
    }
    _loadProducts();
  }

  void _loadProducts() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800)); // Simulating API

    // Mock Data
    _allProducts = List.generate(30, (index) {
      double price = (index + 1) * 50.0 + (index % 5) * 10;
      String cat = index % 3 == 0
          ? "Electrónica"
          : (index % 3 == 1 ? "Ropa" : "Hogar");
      // Override initial category filter from mock if needed, or just generate mixed
      return Product(
        "$index",
        "Producto $index",
        price,
        "https://picsum.photos/id/${index + 10}/200/300",
        index % 5 == 0 ? "NUEVO" : null,
        category: cat,
        rating: 3.5 + (index % 15) / 10,
        dateAdded: DateTime.now().subtract(Duration(days: index)),
      );
    });

    _applyFilters();
    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void setPriceRange(RangeValues range) {
    _priceRange = range;
    _applyFilters();
  }

  void setSortOption(SortOption option) {
    _selectedSort = option;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredProducts = _allProducts.where((product) {
      final matchesSearch = product.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesCategory =
          _selectedCategory == 'Todos' ||
          _selectedCategory == 'Sin categoría' ||
          product.category == _selectedCategory; // Simple match
      final matchesPrice =
          product.price >= _priceRange.start &&
          product.price <= _priceRange.end;

      return matchesSearch && matchesCategory && matchesPrice;
    }).toList();

    _sortProducts();
    notifyListeners();
  }

  void _sortProducts() {
    switch (_selectedSort) {
      case SortOption.priceLowToHigh:
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.newest:
        _filteredProducts.sort((a, b) {
          final dateA = a.dateAdded ?? DateTime(0);
          final dateB = b.dateAdded ?? DateTime(0);
          return dateB.compareTo(dateA);
        });
        break;
    }
  }
}
