class DashboardRepository {
  // Simulating a data source
  Future<DashboardData> fetchDashboardData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return DashboardData(
      sales: 1250.50,
      pendingOrders: 8,
      lowStock: 3,
      users: 45,
      todaySales: _generateTodaySales(),
      yesterdaySales: _generateYesterdaySales(),
    );
  }

  List<double> _generateTodaySales() {
    return [
      50,
      30,
      20,
      10,
      15,
      40,
      120,
      250,
      400,
      600,
      750,
      900,
      850,
      700,
      650,
      600,
      500,
      650,
      900,
      1200,
      1400,
      1100,
      800,
      400,
    ];
  }

  List<double> _generateYesterdaySales() {
    return [
      40,
      20,
      15,
      10,
      20,
      60,
      150,
      300,
      500,
      700,
      900,
      1100,
      1000,
      800,
      700,
      650,
      600,
      800,
      1100,
      1500,
      1700,
      1300,
      900,
      500,
    ];
  }
}

class DashboardData {
  final double sales;
  final int pendingOrders;
  final int lowStock;
  final int users;
  final List<double> todaySales;
  final List<double> yesterdaySales;

  DashboardData({
    required this.sales,
    required this.pendingOrders,
    required this.lowStock,
    required this.users,
    required this.todaySales,
    required this.yesterdaySales,
  });
}
