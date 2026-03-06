import 'package:flutter/material.dart';
import 'package:e_commerce/features/admin/product/view/widgets/admin_product_grid.dart';
import 'package:e_commerce/features/admin/product/view/widgets/admin_product_list.dart';

class ProductAdmin extends StatefulWidget {
  const ProductAdmin({super.key});

  @override
  State<ProductAdmin> createState() => _ProductAdminState();
}

class _ProductAdminState extends State<ProductAdmin> {
  bool isList = true;
  int selectedFilter = 0;

  final filters = ["Todo", "Ropa", "Accesorios", "Calzado", "Electrónica"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Productos",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          /// FILTROS
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isSelected = selectedFilter == index;

                return ChoiceChip(
                  label: Text(filters[index]),
                  selected: isSelected,
                  showCheckmark: false,
                  onSelected: (_) {
                    setState(() {
                      selectedFilter = index;
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          /// LISTA
          if (isList) const Expanded(child: AdminProductList()),
          if (!isList) const Expanded(child: AdminProductGrid()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lista"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Grid"),
        ],
        currentIndex: isList ? 0 : 1,
        onTap: (index) {
          setState(() {
            isList = index == 0;
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          debugPrint("Nuevo Producto");
        },
        label: const Text("Nuevo Producto"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
