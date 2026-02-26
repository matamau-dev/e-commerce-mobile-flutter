import 'package:e_commerce/features/admin/dashboard/model/kpi_metric.dart';
import 'package:e_commerce/features/admin/dashboard/model/kpi_status.dart';
import 'package:e_commerce/features/admin/dashboard/view_model/chart_state.dart';

class DashboardState {
  final KpiMetric<double> sales;
  final KpiMetric<int> pendingOrders;
  final KpiMetric<int> lowStock;
  final KpiMetric<int> users;
  final ChartState chart;
  final bool isLoading;

  const DashboardState({
    this.sales = const KpiMetric(
      value: 0.0,
      status: KpiStatus.normal,
      formatted: "\$0.00",
    ),
    this.pendingOrders = const KpiMetric(
      value: 0,
      status: KpiStatus.success,
      formatted: "0",
    ),
    this.lowStock = const KpiMetric(
      value: 0,
      status: KpiStatus.success,
      formatted: "0",
    ),
    this.users = const KpiMetric(
      value: 0,
      status: KpiStatus.normal,
      formatted: "0",
    ),
    this.chart = const ChartState(),
    this.isLoading = false,
  });

  DashboardState copyWith({
    KpiMetric<double>? sales,
    KpiMetric<int>? pendingOrders,
    KpiMetric<int>? lowStock,
    KpiMetric<int>? users,
    ChartState? chart,
    bool? isLoading,
  }) {
    return DashboardState(
      sales: sales ?? this.sales,
      pendingOrders: pendingOrders ?? this.pendingOrders,
      lowStock: lowStock ?? this.lowStock,
      users: users ?? this.users,
      chart: chart ?? this.chart,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
