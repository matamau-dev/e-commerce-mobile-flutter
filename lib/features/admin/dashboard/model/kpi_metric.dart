import 'package:e_commerce/features/admin/dashboard/model/kpi_status.dart';

class KpiMetric<T> {
  final T value;
  final KpiStatus status;
  final String formatted;

  const KpiMetric({
    required this.value,
    required this.status,
    required this.formatted,
  });
}
