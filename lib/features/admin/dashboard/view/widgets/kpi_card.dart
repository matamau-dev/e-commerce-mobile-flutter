import 'package:e_commerce/features/admin/dashboard/model/kpi_metric.dart';
import 'package:e_commerce/features/admin/dashboard/model/kpi_status.dart';
import 'package:flutter/material.dart';

class DashboardKpiCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final KpiMetric metric;
  final VoidCallback? onTap;

  const DashboardKpiCard({
    super.key,
    required this.title,
    required this.icon,
    required this.metric,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final (bg, text) = _getColor(metric, colors);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: bg.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: text, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: textStyles.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              Text(
                metric.formatted,
                style: textStyles.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

(Color bg, Color text) _getColor(KpiMetric metric, ColorScheme colors) {
  switch (metric.status) {
    case KpiStatus.success:
      return (colors.primaryContainer, colors.onPrimaryContainer);
    case KpiStatus.warning:
      return (colors.secondaryContainer, colors.onSecondaryContainer);
    case KpiStatus.critical:
      return (colors.errorContainer, colors.onErrorContainer);
    case KpiStatus.normal:
      return (colors.surfaceContainer, colors.onSurface);
  }
}
