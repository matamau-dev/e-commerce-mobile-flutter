import 'package:e_commerce/features/customer/profile/domain/data/models/order_model.dart';
import 'package:e_commerce/features/customer/profile/domain/data/models/profile_models.dart';
import 'package:e_commerce/features/customer/profile/domain/profile_action_enum.dart';
import 'package:flutter/material.dart';

class ProfileMenuConfig {
  static List<ProfileSection> getSections() {
    return [
      ProfileSection(
        title: "Mis pedidos",
        actionLabel: "Ver todos",
        actionId: "view_all_orders",
        options: [
          MenuOption(
            title: "Pendientes de",
            subtitle: "pago",
            icon: Icons.money,
            route: '/orders',
            arguments: {
              'title': "Pendientes de pago",
              'filterStatuses': [OrderStatus.pending],
            },
          ),
          MenuOption(
            title: "Pendientes de",
            subtitle: "entrega",
            icon: Icons.holiday_village_outlined,
            route: '/orders',
            arguments: {
              'title': "Pendientes de entrega",
              'filterStatuses': [
                OrderStatus.paid,
                OrderStatus.processing,
                OrderStatus.shipped,
              ],
            },
          ),
          MenuOption(
            title: "Enviados",
            subtitle: "",
            icon: Icons.local_shipping_outlined,
            route: '/orders',
            arguments: {
              'title': "Enviados",
              'filterStatuses': [OrderStatus.shipped],
            },
          ),
          MenuOption(
            title: "Añadir reseña",
            subtitle: "",
            icon: Icons.chat_bubble_outline,
            route: '/orders',
            arguments: {
              'title': "Historial (Añadir Reseña)",
              'filterStatuses': [OrderStatus.delivered],
            },
          ),
          MenuOption(
            title: "Devoluciones",
            subtitle: "",
            icon: Icons.reply,
            route: '/orders',
            arguments: {
              'title': "Devoluciones y Cancelaciones",
              'filterStatuses': [OrderStatus.cancelled, OrderStatus.returned],
            },
          ),
        ],
      ),

      ProfileSection(
        title: "Mi Actividad",
        options: [
          MenuOption(
            title: "Historial",
            subtitle: "vistos",
            icon: Icons.history,
            id: ProfileOptionId.historyViewed.name,
          ),
          MenuOption(
            title: "Deseos",
            subtitle: "guardados",
            icon: Icons.favorite_border,
            id: ProfileOptionId.wishlist.name,
          ),
          MenuOption(
            title: "Cupones",
            subtitle: "",
            icon: Icons.card_giftcard,
            id: ProfileOptionId.coupons.name,
          ),
        ],
      ),

      ProfileSection(
        title: "Ayuda y Legal",
        options: [
          MenuOption(
            title: "Ayuda",
            subtitle: "",
            icon: Icons.help_outline,
            route: '/help',
          ),
          MenuOption(
            title: "Términos",
            subtitle: "",
            icon: Icons.info_outline,
            route: '/legal',
            arguments: {'title': "Términos y Condiciones", 'type': "terms"},
          ),
          MenuOption(
            title: "Privacidad",
            subtitle: "",
            icon: Icons.lock_outline,
            route: '/legal',
            arguments: {'title': "Política de Privacidad", 'type': "privacy"},
          ),
          MenuOption(
            title: "Sugerencias",
            subtitle: "",
            icon: Icons.chat_bubble_outline,
            id: ProfileOptionId.suggestions.name,
          ),
          MenuOption(
            title: "Preguntas frecuentes",
            subtitle: "",
            icon: Icons.question_answer_outlined,
            route: '/help',
          ),
        ],
      ),
    ];
  }
}
