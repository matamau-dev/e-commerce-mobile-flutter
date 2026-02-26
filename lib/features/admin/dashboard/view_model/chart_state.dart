import 'package:fl_chart/fl_chart.dart';

class ChartState {
  final bool isHourly;
  final List<FlSpot> todaySpots;
  final List<FlSpot> yesterdaySpots;

  const ChartState({
    this.isHourly = true,
    this.todaySpots = const [],
    this.yesterdaySpots = const [],
  });

  ChartState copyWith({
    bool? isHourly,
    List<FlSpot>? todaySpots,
    List<FlSpot>? yesterdaySpots,
  }) {
    return ChartState(
      isHourly: isHourly ?? this.isHourly,
      todaySpots: todaySpots ?? this.todaySpots,
      yesterdaySpots: yesterdaySpots ?? this.yesterdaySpots,
    );
  }
}
