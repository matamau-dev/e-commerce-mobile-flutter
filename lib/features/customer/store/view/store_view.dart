import 'package:e_commerce/features/customer/products/view/widgets/filter_bottom_sheet.dart';
import 'package:e_commerce/features/customer/products/view_model/product_list_view_model.dart';
import 'package:e_commerce/presentation/widgets/cards/product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  final List<String> _categories = [
    "Todos",
    "Ropa",
    "Calzado",
    "Electrónica",
    "Hogar",
    "Accesorios",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = context.watch<ProductListViewModel>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Elegant Sliver App Bar with Search
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: theme.colorScheme.surface, // Avoid color tint
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                "Tienda",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              background: Container(color: theme.colorScheme.surface),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                color: theme.colorScheme.surface,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) => viewModel.setSearchQuery(value),
                        decoration: InputDecoration(
                          hintText: "Buscar productos...",
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceVariant
                              .withOpacity(0.3),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ), // Pill shape for search
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: theme.colorScheme.primary.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filledTonal(
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
                      icon: const Icon(Icons.tune),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Filter Chips using SliverToBoxAdapter
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected =
                      viewModel.selectedCategory == category ||
                      (viewModel.selectedCategory == 'Sin categoría' &&
                          category ==
                              'Todos'); // Handle 'Todos' mapping if needed

                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        viewModel.setCategory(category);
                      }
                    },
                    selectedColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                    backgroundColor: theme.colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? Colors.transparent
                            : theme.colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    showCheckmark: false,
                  );
                },
              ),
            ),
          ),

          if (viewModel.isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (viewModel.products.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      "No se encontraron productos",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            )
          else
            // Product Grid
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.60, // Adjust card aspect ratio
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = viewModel.products[index];
                  return ProductCard(
                    title: product.title,
                    price: product.price,
                    imageUrl: product.imageUrl,
                    tagLabel: product.tagLabel,
                    onTap: () => context.push('/product'),
                    onAdd: () {}, // Could connect to CartViewModel if needed
                  );
                }, childCount: viewModel.products.length),
              ),
            ),
        ],
      ),
    );
  }
}
