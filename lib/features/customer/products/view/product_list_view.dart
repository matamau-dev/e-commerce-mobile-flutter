import 'package:e_commerce/features/customer/products/view/widgets/filter_bottom_sheet.dart';
import 'package:e_commerce/features/customer/products/view_model/product_list_view_model.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:e_commerce/presentation/widgets/cards/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key, required this.category});
  final String category;

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  bool _isSearch = false;

  @override
  void initState() {
    super.initState();
    // Set initial category if needed. ViewModel handle this via constructor/provider creation
    // but we can enforce it here if we want dynamic updates or just rely on the provider creation in router.
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductListViewModel>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: CustomAppBar(
          title: _isSearch ? "Buscar" : widget.category,
          showSearchBar: _isSearch,
          onSearchChanged: (value) {
            viewModel.setSearchQuery(value);
          },
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() => _isSearch = !_isSearch);
                if (!_isSearch) {
                  viewModel.setSearchQuery(''); // Clear search on close
                }
              },
            ),

            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => FilterBottomSheet(
                    currentPriceRange: viewModel.priceRange,
                    currentSortOption: viewModel.selectedSort,
                    onApply: (range, sort) {
                      viewModel.setPriceRange(range);
                      viewModel.setSortOption(sort);
                    },
                  ),
                );
              },
            ),
          ],
        ),

        body: Column(
          children: [
            if (viewModel.isLoading) const LinearProgressIndicator(),

            // Active Filters Chips (Optional - can add later)
            Expanded(
              child: viewModel.products.isEmpty && !viewModel.isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No se encontraron productos",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )
                  : ProductGrid(
                      isScrollable: true,
                      products: viewModel.products,
                      onProductTap: (product) {
                        // Decide if we pass object or fetch by ID.
                        // For now, simple navigation.
                        context.push("/product");
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
