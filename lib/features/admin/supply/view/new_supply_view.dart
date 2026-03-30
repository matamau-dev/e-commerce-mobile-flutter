import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';

class NewSupplyView extends StatefulWidget {
  const NewSupplyView({super.key});

  @override
  State<NewSupplyView> createState() => _NewSupplyViewState();
}

class _NewSupplyViewState extends State<NewSupplyView> {
  // Datos simulados (Esto vendría de tu Provider/Backend)
  String? selectedSupplier;
  List<Map<String, dynamic>> selectedProducts = [
    {"name": "Leche Entera 1L", "price": 15.50, "qty": 10},
    {"name": "Yogur Griego", "price": 22.00, "qty": 5},
  ];

  double get total => selectedProducts.fold(
    0,
    (sum, item) => sum + (item['price'] * item['qty']),
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva Orden de Compra"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. SECCIÓN DE PROVEEDOR
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildSupplierSelector(colors),
          ),

          const Divider(height: 1),

          // 2. LISTA DE PRODUCTOS A PEDIR
          Expanded(
            child: selectedProducts.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: selectedProducts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = selectedProducts[index];
                      return _buildProductItem(item, index, colors);
                    },
                  ),
          ),

          // 3. BOTÓN PARA AGREGAR MÁS PRODUCTOS
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton.icon(
              onPressed: () => _showProductSearch(context),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Agregar Producto al Pedido"),
            ),
          ),
        ],
      ),

      // 4. RESUMEN Y ACCIÓN FINAL
      bottomNavigationBar: _buildBottomSummary(colors),
    );
  }

  // --- WIDGETS DE APOYO ---

  Widget _buildSupplierSelector(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const CircleAvatar(child: Icon(Icons.business)),
        title: Text(
          selectedSupplier ?? "Seleccionar Proveedor",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("Toca para buscar en tu lista"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Aquí abrirías un SearchDelegate o Modal con tus proveedores
          setState(() => selectedSupplier = "Distribuidora de Lácteos S.A.");
        },
      ),
    );
  }

  Widget _buildProductItem(
    Map<String, dynamic> item,
    int index,
    ColorScheme colors,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Costo Unitario: \$${item['price']}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          // Selector de cantidad
          Row(
            children: [
              _qtyButton(Icons.remove, () {
                setState(() => item['qty'] > 1 ? item['qty']-- : null);
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "${item['qty']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              _qtyButton(Icons.add, () {
                setState(() => item['qty']++);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }

  Widget _buildBottomSummary(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Estimado:",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  "\$${total.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: "Generar Orden de Compra",
              onPressed: selectedSupplier == null || selectedProducts.isEmpty
                  ? null
                  : () => debugPrint("Orden Guardada"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_shopping_cart, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "No has agregado productos al pedido",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _showProductSearch(BuildContext context) {
    // Aquí abrirías el Modal que diseñamos antes para proveedores
    // Pero filtrando productos del catálogo global.
  }
}
