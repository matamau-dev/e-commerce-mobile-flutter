import 'package:flutter/material.dart';

class ProductSelectionModal extends StatelessWidget {
  const ProductSelectionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Seleccionar Productos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: 15,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.inventory_2_outlined),
                  title: Text("Producto de catálogo #$index"),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
