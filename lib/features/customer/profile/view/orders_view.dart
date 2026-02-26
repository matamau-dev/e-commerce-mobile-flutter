import 'package:e_commerce/features/customer/profile/domain/models/order_model.dart';
import 'package:e_commerce/features/customer/profile/view_model/order_view_model.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatelessWidget {
  final List<OrderStatus> filterStatuses;
  final String title;

  const OrdersView({
    super.key,
    required this.filterStatuses,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // In a real app, you might fetch data here based on filter.
    // For now, we assume ViewModel has all data and we filter it.
    final allOrders = context.read<OrderViewModel>().getOrders(
      filterStatuses: filterStatuses,
    );

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: allOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No hay pedidos en esta sección",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: allOrders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final order = allOrders[index];
                return _OrderCard(order: order);
              },
            ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderModel order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pedido ${order.id}",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: order.status.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: order.status.color.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    order.status.label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: order.status.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: colorScheme.outline,
                ),
                const SizedBox(width: 4),
                Text(
                  "${order.date.day}/${order.date.month}/${order.date.year}",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
                const Spacer(),
                Text(
                  "${order.itemCount} art.",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                    Text(
                      "\$${order.total.toStringAsFixed(2)}",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push('/order_detail', extra: order);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: colorScheme.surfaceVariant,
                    foregroundColor: colorScheme.onSurfaceVariant,
                    elevation: 0,
                  ),
                  child: const Text("Ver Detalles"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
