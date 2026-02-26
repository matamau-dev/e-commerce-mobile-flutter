import 'package:e_commerce/features/admin/dashboard/view_model/dashboard_view_model.dart';
import 'package:e_commerce/features/admin/dashboard/view/widgets/action_panel.dart';
import 'package:e_commerce/features/admin/dashboard/view/widgets/graphic_kpi.dart';
import 'package:e_commerce/features/admin/dashboard/view/widgets/kpi_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    // Watch logic so the view rebuilds
    final vm = context.watch<DashboardViewModel>();
    final state = vm.state;

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Resumen Operativo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.count(
                childAspectRatio: 1.1,
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DashboardKpiCard(
                    title: "Ventas",
                    icon: Icons.attach_money,
                    metric: state.sales,
                    onTap: vm.onViewSales,
                  ),
                  DashboardKpiCard(
                    title: "Pendientes",
                    icon: Icons.timer,
                    metric: state.pendingOrders,
                    onTap: vm.onViewPendingOrders,
                  ),
                  DashboardKpiCard(
                    title: "Bajo Stock",
                    icon: Icons.warning,
                    metric: state.lowStock,
                    onTap: vm.onViewLowStock,
                  ),
                  DashboardKpiCard(
                    title: "Usuarios",
                    icon: Icons.people,
                    metric: state.users,
                    onTap: vm.onViewUsers,
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: QuickActionsPanel(
                    onProduct: vm.onQuickActionProduct,
                    onScan: vm.onQuickActionScan,
                    onCoupon: vm.onQuickActionCoupon,
                    onStock: vm.onQuickActionStock,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: vm.onViewAllEarnings,
                child: const GraphicKpi(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
