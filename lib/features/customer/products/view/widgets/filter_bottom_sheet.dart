import 'package:e_commerce/features/customer/products/view_model/product_list_view_model.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final RangeValues currentPriceRange;
  final SortOption currentSortOption;
  final Function(RangeValues, SortOption) onApply;

  const FilterBottomSheet({
    super.key,
    required this.currentPriceRange,
    required this.currentSortOption,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late RangeValues _priceRange;
  late SortOption _sortOption;

  @override
  void initState() {
    super.initState();
    _priceRange = widget.currentPriceRange;
    _sortOption = widget.currentSortOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filtros",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Rango de Precio",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 5000,
            divisions: 50,
            labels: RangeLabels(
              "\$${_priceRange.start.round()}",
              "\$${_priceRange.end.round()}",
            ),
            onChanged: (values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${_priceRange.start.round()}"),
              Text("\$${_priceRange.end.round()}"),
            ],
          ),

          const SizedBox(height: 24),
          Text("Ordenar por", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _buildSortChip("Más Recientes", SortOption.newest),
              _buildSortChip(
                "Precio: Menor a Mayor",
                SortOption.priceLowToHigh,
              ),
              _buildSortChip(
                "Precio: Mayor a Menor",
                SortOption.priceHighToLow,
              ),
            ],
          ),

          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply(_priceRange, _sortOption);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Aplicar Filtros"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label, SortOption option) {
    final isSelected = _sortOption == option;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => _sortOption = option);
        }
      },
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Colors.black87,
      ),
    );
  }
}
