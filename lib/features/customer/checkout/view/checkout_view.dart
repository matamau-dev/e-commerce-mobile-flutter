import 'package:e_commerce/features/customer/address/view/addresses_view.dart';
import 'package:e_commerce/features/customer/checkout/view_model/checkout_view_model.dart';
import 'package:e_commerce/presentation/widgets/cards/order_summary_card.dart';
import 'package:e_commerce/features/customer/payment/view/payments_view.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CheckoutViewModel>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(title: "Finalizar Compra"),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step 1: Shipping Address
                  _buildSectionHeader(context, "1", "Dirección de Envío"),
                  const SizedBox(height: 12),
                  _buildAddressCard(context, viewModel),
                  const SizedBox(height: 24),

                  // Step 2: Payment Method
                  _buildSectionHeader(context, "2", "Método de Pago"),
                  const SizedBox(height: 12),
                  _buildPaymentCard(context, viewModel),
                  const SizedBox(height: 24),

                  // Step 3: Order Summary
                  _buildSectionHeader(context, "3", "Resumen del Pedido"),
                  const SizedBox(height: 12),
                  _buildOrderSummary(context, viewModel),
                  const SizedBox(height: 32),

                  // Action Button
                  CustomButton(
                    text:
                        "Confirmar y Pagar \$${viewModel.total.toStringAsFixed(2)}",
                    onPressed: () async {
                      final success = await viewModel.placeOrder();
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("¡Pedido realizado con éxito!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        context.go('/'); // Navigate home or to orders
                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Por favor selecciona una dirección y método de pago",
                            ),
                            backgroundColor: theme.colorScheme.error,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String number,
    String title,
  ) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildAddressCard(BuildContext context, CheckoutViewModel viewModel) {
    final address = viewModel.selectedAddress;

    // If no address selected, show add button or empty state
    if (address == null) {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (context) => const AddressesView()),
              )
              .then((_) {
                viewModel.refreshData();
              });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(12),
            // borderStyle: BorderStyle.dashed is not valid on Border.all, use custom decoration or image for dashed
          ),
          child: Column(
            children: [
              Icon(
                Icons.add_location_alt_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                "Seleccionar dirección",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.grey),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        address.fullAddress,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddressesView(),
                      ),
                    );
                  },
                  child: const Text("Cambiar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context, CheckoutViewModel viewModel) {
    final payment = viewModel.selectedPaymentMethod;

    if (payment == null) {
      return InkWell(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const PaymentsView()));
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(12),
            // dashed border omitted for standard border
          ),
          child: Column(
            children: [
              Icon(
                Icons.credit_card,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                "Seleccionar método de pago",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.credit_card, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.cardHolderName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "**** ${payment.hiddenNumber.split(' ').last}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => const PaymentsView(),
                      ),
                    )
                    .then((_) => viewModel.refreshData());
              },
              child: const Text("Cambiar"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CheckoutViewModel viewModel) {
    return OrderSummaryCard(
      subtotal: viewModel.subtotal,
      shipping: viewModel.shipping,
      tax: viewModel.tax,
      total: viewModel.total,
    );
  }
}
