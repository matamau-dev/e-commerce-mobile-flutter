import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SupplyView extends StatefulWidget {
  const SupplyView({super.key});

  @override
  State<SupplyView> createState() => _SupplyViewState();
}

class _SupplyViewState extends State<SupplyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. TÍTULO Y BOTÓN DE ACCIÓN
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Gestión de Suministros",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // Botón circular o pequeño para agregar nueva orden
                  IconButton.filled(
                    onPressed: () => context.push("/new-supply"),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. INDICADORES (Tus KPI Cards actuales pero con estilo)
              // Puedes usar un PageView o un ListView horizontal si quieres ahorrar espacio vertical
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCompactKpi(
                      "En Tránsito",
                      "5",
                      Colors.blue,
                      Icons.local_shipping,
                    ),
                    _buildCompactKpi(
                      "Por Recibir",
                      "2",
                      Colors.orange,
                      Icons.pending_actions,
                    ),
                    _buildCompactKpi(
                      "Inversión",
                      "\$12k",
                      Colors.green,
                      Icons.monetization_on,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 3. SECCIÓN DE ACTIVIDAD RECIENTE (Aquí está el alma de la vista)
              const Text(
                "Órdenes de Compra Recientes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Lista de órdenes reales
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4, // Esto vendría de tu backend
                itemBuilder: (context, index) {
                  return _buildOrderListItem(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildOrderListItem(BuildContext context) {
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.business), // Aquí iría el logo del proveedor
      ),
      title: const Text(
        "Distribuidora Global",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text("15 Productos • Hace 2 horas"),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "\$2,400.00",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              "Pendiente",
              style: TextStyle(color: Colors.orange, fontSize: 10),
            ),
          ),
        ],
      ),
      onTap: () {
        // Ir al detalle de la orden
      },
    ),
  );
}

Widget _buildCompactKpi(
  String title,
  String value,
  Color color,
  IconData icon,
) {
  return Container(
    width: 150, // Ancho fijo para que el ListView horizontal funcione bien
    margin: const EdgeInsets.only(right: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1), // Fondo muy suave del color del tema
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: color, size: 28),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color.withValues(alpha: 0.9),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
