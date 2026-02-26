import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';

class ProductBottomAction extends StatelessWidget {
  final VoidCallback onAdd;

  const ProductBottomAction({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        height: 50,
        child: CustomButton(
          text: "Agregar al Carrito",
          onPressed: onAdd,
          icon: Icons.shopping_bag_outlined,
        ),
      ),
    );
  }
}
