import 'package:e_commerce/features/admin/dashboard/view_model/dashboard_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphicKpi extends StatelessWidget {
  const GraphicKpi({super.key});

  @override
  Widget build(BuildContext context) {
    // Ideally we should pass the callback down or use a specific selector causing rebuild only on chart changes.
    // However, since this widget is tightly coupled to VM logic for chart toggling, we keep VM access but cleaner.

    final vm = context.read<DashboardViewModel>();
    final chartState = context.select(
      (DashboardViewModel vm) => vm.state.chart,
    );

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _Header(onTap: vm.onViewAllEarnings),
            const SizedBox(height: 16),
            _Selectors(
              isHourly: chartState.isHourly,
              onHourly: () => vm.setChartMode(true),
              onAccumulated: () => vm.setChartMode(false),
            ),
            const SizedBox(height: 20),
            _ChartCanvas(chartState: chartState),
            const SizedBox(height: 16),
            const _Legend(),
          ],
        ),
      ),
    );
  }
}

// --- Componentes privados para no ensuciar el build principal ---

class _Header extends StatelessWidget {
  final VoidCallback onTap;
  const _Header({required this.onTap});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Comparativa de Ganancias",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      IconButton(
        onPressed: onTap,
        icon: Icon(Icons.arrow_forward_ios, size: 14),
      ),
    ],
  );
}

class _Selectors extends StatelessWidget {
  final bool isHourly;
  final VoidCallback onHourly;
  final VoidCallback onAccumulated;

  const _Selectors({
    required this.isHourly,
    required this.onHourly,
    required this.onAccumulated,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: const Text("Por Hora"),
          selected: isHourly,
          onSelected: (val) => onHourly(),
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text("Acumulado"),
          selected: !isHourly,
          onSelected: (val) => onAccumulated(),
        ),
      ],
    );
  }
}

class _ChartCanvas extends StatelessWidget {
  final chartState;
  const _ChartCanvas({required this.chartState});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: _buildTitles(),
          lineBarsData: [
            _lineData(
              chartState.yesterdaySpots,
              colors.secondary.withOpacity(0.3),
            ),
            _lineData(chartState.todaySpots, colors.primary),
          ],
        ),
      ),
    );
  }

  LineChartBarData _lineData(List<FlSpot> spots, Color color) =>
      LineChartBarData(
        spots: spots,
        isCurved: true,
        barWidth: 3,
        color: color,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      );

  FlTitlesData _buildTitles() => FlTitlesData(
    // Aquí pones la lógica de los ejes que ya teníamos (value % 6 == 0, etc.)
    show: true,
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}

class _Legend extends StatelessWidget {
  const _Legend();
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Dot(color: colors.primary, label: "Hoy"),
        const SizedBox(width: 16),
        _Dot(color: colors.secondary.withOpacity(0.4), label: "Ayer"),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final String label;
  const _Dot({required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 12)),
    ],
  );
}
