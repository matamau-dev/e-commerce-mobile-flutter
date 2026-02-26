import 'package:e_commerce/features/admin/dashboard/model/dashboard_repository.dart';
import 'package:e_commerce/features/admin/dashboard/model/kpi_metric.dart';
import 'package:e_commerce/features/admin/dashboard/model/kpi_status.dart';
import 'package:e_commerce/features/admin/dashboard/view_model/dashboard_state.dart';
import 'package:e_commerce/features/admin/dashboard/view_model/utils/chart_utils.dart';

import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardState _state = const DashboardState();
  DashboardState get state => _state;

  final DashboardRepository _repository = DashboardRepository();

  DashboardViewModel() {
    _init();
  }

  Future<void> _init() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final data = await _repository.fetchDashboardData();
      _updateDashboardWithData(data);
    } catch (e) {
      debugPrint("Error loading dashboard data: $e");
    } finally {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  void _updateDashboardWithData(DashboardData data) {
    // Business Logic for KPIs
    final salesMetric = _createSalesMetric(data.sales);
    final pendingMetric = _createPendingMetric(data.pendingOrders);
    final lowStockMetric = _createLowStockMetric(data.lowStock);
    final usersMetric = _createUsersMetric(data.users);

    // Chart Logic
    final todaySpots = ChartUtils.generateSpots(
      data.todaySales,
      shouldAccumulate: !_state.chart.isHourly,
    );
    final yesterdaySpots = ChartUtils.generateSpots(
      data.yesterdaySales,
      shouldAccumulate: !_state.chart.isHourly,
    );

    _state = _state.copyWith(
      sales: salesMetric,
      pendingOrders: pendingMetric,
      lowStock: lowStockMetric,
      users: usersMetric,
      chart: _state.chart.copyWith(
        todaySpots: todaySpots,
        yesterdaySpots: yesterdaySpots,
      ),
    );
  }

  /* Business Logic for KPI Thresholds */

  KpiMetric<double> _createSalesMetric(double sales) {
    KpiStatus status;
    if (sales > 1000) {
      status = KpiStatus.success;
    } else if (sales > 500) {
      status = KpiStatus.normal;
    } else {
      status = KpiStatus.critical;
    }
    return KpiMetric(
      value: sales,
      status: status,
      formatted: "\$${sales.toStringAsFixed(2)}",
    );
  }

  KpiMetric<int> _createPendingMetric(int pending) {
    KpiStatus status;
    if (pending > 10) {
      status = KpiStatus.critical;
    } else if (pending > 5) {
      status = KpiStatus.warning;
    } else {
      status = KpiStatus.success;
    }
    return KpiMetric(value: pending, status: status, formatted: "$pending");
  }

  KpiMetric<int> _createLowStockMetric(int lowStock) {
    KpiStatus status;
    if (lowStock > 10) {
      status = KpiStatus.critical;
    } else if (lowStock > 5) {
      status = KpiStatus.warning;
    } else {
      status = KpiStatus.success;
    }
    return KpiMetric(value: lowStock, status: status, formatted: "$lowStock");
  }

  KpiMetric<int> _createUsersMetric(int users) {
    KpiStatus status;
    if (users > 50) {
      status = KpiStatus.success;
    } else if (users > 20) {
      status = KpiStatus.normal;
    } else {
      status = KpiStatus.warning;
    }
    return KpiMetric(value: users, status: status, formatted: "$users");
  }

  /* Interaction Methods */

  void setChartMode(bool isHourly) {
    if (_state.chart.isHourly == isHourly) return;

    _state = _state.copyWith(chart: _state.chart.copyWith(isHourly: isHourly));
    // Re-fetch or re-calculate chart data needed?
    // Ideally we should keep the raw data in the VM or Repository to re-calculate without re-fetching.
    // For now, let's just re-init to simulate a refresh or better, store data locally.
    // Since I didn't store raw data in VM state, I will implement a quick fix:
    // Ideally this refactor should have stored the raw lists in the VM.

    // Rerunning init is easy but slow.
    // Let's improve this: Store the last fetched data in the VM.
    _refreshChartWithCurrentData();
    notifyListeners();
  }

  // Stored data for toggling chart mode without network call
  DashboardData? _lastData;

  Future<void> _refreshChartWithCurrentData() async {
    if (_lastData == null) {
      await _init(); // Fallback
      return;
    }

    final todaySpots = ChartUtils.generateSpots(
      _lastData!.todaySales,
      shouldAccumulate: !_state.chart.isHourly,
    );
    final yesterdaySpots = ChartUtils.generateSpots(
      _lastData!.yesterdaySales,
      shouldAccumulate: !_state.chart.isHourly,
    );

    _state = _state.copyWith(
      chart: _state.chart.copyWith(
        todaySpots: todaySpots,
        yesterdaySpots: yesterdaySpots,
      ),
    );
  }

  // View Actions
  void onViewSales() {
    debugPrint("Navigating to Sales Details...");
    // navigation logic
  }

  void onViewPendingOrders() {
    debugPrint("Navigating to Pending Orders...");
  }

  void onViewLowStock() {
    debugPrint("Navigating to Low Stock...");
  }

  void onViewUsers() {
    debugPrint("Navigating to Users...");
  }

  void onQuickActionProduct() {
    debugPrint("Quick Action: New Product");
  }

  void onQuickActionScan() {
    debugPrint("Quick Action: Scan");
  }

  void onQuickActionCoupon() {
    debugPrint("Quick Action: New Coupon");
  }

  void onQuickActionStock() {
    debugPrint("Quick Action: Stock Management");
  }

  void onViewAllEarnings() {
    debugPrint("Navigating to All Earnings...");
  }
}
