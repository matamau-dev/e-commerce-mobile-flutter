import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Ayuda y Soporte"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Preguntas Frecuentes",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildFaqItem(
            context,
            "¿Cómo rastreo mi pedido?",
            "Puedes rastrear tu pedido desde la sección 'Mis Pedidos' en tu perfil. Selecciona el pedido que deseas consultar y verás su estado actual.",
          ),
          _buildFaqItem(
            context,
            "¿Cuáles son los métodos de pago?",
            "Aceptamos tarjetas de crédito, débito, PayPal y pagos en efectivo en tiendas participantes.",
          ),
          _buildFaqItem(
            context,
            "¿Cómo solicito una devolución?",
            "Ve a 'Mis Pedidos', selecciona el pedido y presiona 'Solicitar Devolución'. Sigue los pasos indicados.",
          ),
          _buildFaqItem(
            context,
            "¿Hacen envíos internacionales?",
            "Actualmente solo realizamos envíos dentro del territorio nacional. Estamos trabajando para expandirnos pronto.",
          ),
          const SizedBox(height: 32),
          Text(
            "Contáctanos",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            context,
            icon: Icons.email_outlined,
            title: "Correo Electrónico",
            subtitle: "soporte@ecommerce.com",
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _buildContactItem(
            context,
            icon: Icons.phone_outlined,
            title: "Teléfono",
            subtitle: "+52 55 1234 5678",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: ExpansionTile(
        shape: Border.all(color: Colors.transparent),
        collapsedShape: Border.all(color: Colors.transparent),
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.8),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
    );
  }
}
