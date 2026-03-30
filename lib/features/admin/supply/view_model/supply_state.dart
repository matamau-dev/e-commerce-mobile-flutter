import 'package:e_commerce/features/admin/dashboard/model/kpi_metric.dart';
import 'package:e_commerce/features/admin/dashboard/model/kpi_status.dart';
import 'package:e_commerce/features/admin/dashboard/view_model/chart_state.dart';

class SupplyState {
  final KpiMetric<double> sales;
  final KpiMetric<int> pendingOrders;
  final KpiMetric<int> lowStock;
  final KpiMetric<int> users;
  final ChartState chart;
  final bool isLoading;

  const SupplyState({
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
}
