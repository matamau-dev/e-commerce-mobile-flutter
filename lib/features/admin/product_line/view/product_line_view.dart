import 'package:e_commerce/features/admin/product_line/view/widget/product_line_card.dart';
import 'package:e_commerce/features/admin/product_line/view/widget/product_line_filter.dart';
import 'package:e_commerce/features/admin/product_line/view_model/product_line_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductLineView extends StatelessWidget {
  const ProductLineView({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Escuchamos al ViewModel
    final lineVM = context.watch<ProductLineViewModel>();
    final List<String> _categories = [
      "Todos",
      "Ropa",
      "Calzado",
      "Electrónica",
      "Hogar",
      "Accesorios",
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          "Líneas de Producto",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Column(
        children: [
          ProductLineFilter(filters: _categories),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: lineVM.lines.length,
              itemBuilder: (context, index) {
                final line = lineVM.lines[index];
                return ProductLineCard(line: line);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Nueva Línea"),
        icon: const Icon(Icons.add),
        elevation: 3,
      ),
    );
  }
}
