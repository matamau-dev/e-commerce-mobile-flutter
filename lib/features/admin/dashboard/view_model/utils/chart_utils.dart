import 'package:fl_chart/fl_chart.dart';

class ChartUtils {
  static List<FlSpot> generateSpots(
    List<double> rawData, {
    required bool shouldAccumulate,
  }) {
    List<double> processedData = [];

    if (shouldAccumulate) {
      double total = 0;
      processedData = rawData.map((v) => total += v).toList();
    } else {
      processedData = rawData;
    }

    return List.generate(
      processedData.length,
      (i) => FlSpot(i.toDouble(), processedData[i]),
    );
  }
}
