import 'package:e_commerce/features/admin/product_line/view_model/product_line_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductLineView extends StatelessWidget {
  const ProductLineView({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Escuchamos al ViewModel
    final lineVM = context.watch<ProductLineViewModel>();

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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: lineVM.lines.length,
        itemBuilder: (context, index) {
          final line = lineVM.lines[index];
          return _buildProductLineCard(context, line);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Aquí abrirás tu diálogo
        },
        label: const Text("Nueva Línea"),
        icon: const Icon(Icons.add),
        elevation: 3,
      ),
    );
  }

  // 2. Widget de la Card separada para limpiar el código
  Widget _buildProductLineCard(BuildContext context, dynamic line) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.inventory_2_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          line['name'] ?? 'Sin nombre', // "Iphone 12"
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          "Marca: ${line['brand'] ?? 'Sin marca'}", // "Apple"
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => debugPrint("editar"),
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: () => debugPrint("borrar"),
            ),
          ],
        ),
      ),
    );
  }
}
