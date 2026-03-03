import 'package:flutter/material.dart';

class ProductLineListTile extends StatelessWidget {
  final Map<String, String> line;
  const ProductLineListTile({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        line['name'] ?? 'Sin nombre',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        "Marca: ${line['brand'] ?? 'Sin marca'}",
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
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
    );
  }
}
