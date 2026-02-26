import 'package:e_commerce/features/customer/profile/domain/models/activity_models.dart';
import 'package:e_commerce/features/customer/profile/view_model/activity_view_model.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CouponsView extends StatelessWidget {
  const CouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ActivityViewModel>();
    final available = viewModel.availableCoupons;
    final used = viewModel.usedCoupons;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Mis Cupones",
          bottom: const TabBar(
            tabs: [
              Tab(text: "Disponibles"),
              Tab(text: "Usados"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _CouponsList(coupons: available, isAvailable: true),
            _CouponsList(coupons: used, isAvailable: false),
          ],
        ),
      ),
    );
  }
}

class _CouponsList extends StatelessWidget {
  final List<Coupon> coupons;
  final bool isAvailable;

  const _CouponsList({required this.coupons, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    if (coupons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_offer_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              "No tienes cupones en esta sección",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: coupons.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final coupon = coupons[index];
        return _CouponCard(coupon: coupon, isAvailable: isAvailable);
      },
    );
  }
}

class _CouponCard extends StatelessWidget {
  final Coupon coupon;
  final bool isAvailable;

  const _CouponCard({required this.coupon, required this.isAvailable});

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
                  coupon.code,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                if (isAvailable)
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Código copiado al portapapeles"),
                        ),
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(coupon.description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isAvailable
                      ? "Expira: ${coupon.formattedExpiry}"
                      : "Usado el: ${coupon.formattedExpiry}", // Logic could be adjusted if we had usedDate
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: coupon.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: coupon.statusColor.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    isAvailable ? "Disponible" : "Usado",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: coupon.statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
