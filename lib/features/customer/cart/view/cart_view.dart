import 'package:e_commerce/features/customer/cart/view_model/cart_view_model.dart';
import 'package:e_commerce/presentation/widgets/cards/order_summary_card.dart';
import 'package:e_commerce/presentation/widgets/feedback/empty_state.dart';
import 'package:go_router/go_router.dart';
import 'package:e_commerce/features/customer/cart/widget/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tu Carrito (${cartModel.items.length})",
        actions: [
          IconButton(icon: const Icon(Icons.delete_outline), onPressed: () {}),
        ],
      ),
      body: cartModel.isEmpty
          ? const EmptyState(
              icon: Icons.shopping_cart_outlined,
              title: "Tu carrito está vacío",
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),

              itemCount: cartModel.items.length + 1,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                if (index == cartModel.items.length) {
                  return OrderSummaryCard(
                    subtotal: cartModel.subtotal,
                    shipping: cartModel.shipping,
                    tax: cartModel.tax,
                    total: cartModel.total,
                  );
                }

                final item = cartModel.items[index];
                return CartItem(
                  title: item["title"],
                  price: item["price"],
                  imageUrl: item["img"],
                  quantity: item["qty"],
                  onIncrement: () => cartModel.incrementQuantity(index),
                  onDecrement: () => cartModel.decrementQuantity(index),
                  onRemove: () => cartModel.removeItem(index),
                );
              },
            ),

      bottomNavigationBar: cartModel.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  height: 50,
                  child: CustomButton(
                    text: "Pagar \$${cartModel.total.toStringAsFixed(2)}",
                    onPressed: () {
                      context.push('/checkout');
                    },
                    icon: Icons.payment,
                  ),
                ),
              ),
            ),
    );
  }
}
