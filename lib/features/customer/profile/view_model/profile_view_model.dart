import 'package:e_commerce/features/customer/profile/domain/models/order_model.dart';
import 'package:e_commerce/features/customer/profile/domain/models/profile_models.dart';
import 'package:e_commerce/features/customer/profile/domain/models/user_model.dart';
import 'package:e_commerce/features/customer/profile/view_model/activity_view_model.dart';
import 'package:e_commerce/features/customer/profile/widget/suggestion_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileViewModel extends ChangeNotifier {
  // Mock User
  UserModel _user = const UserModel(
    id: "u1",
    name: "Mauricio Mátuz",
    email: "example@gmail.com",
    phone: "+52 55 1234 5678",
    imageUrl: "https://i.pravatar.cc/300",
  );

  UserModel get user => _user;

  void updateUser(String name, String email, String phone) {
    _user = _user.copyWith(name: name, email: email, phone: phone);
    notifyListeners();
  }

  void updateProfileImage() {
    // Mock updating image to a different one
    // In a real app, this would involve picking an image file and uploading it
    final newImage = _user.imageUrl.contains("300")
        ? "https://i.pravatar.cc/301" // Just toggling ID to show change
        : "https://i.pravatar.cc/300";

    _user = _user.copyWith(imageUrl: newImage);
    notifyListeners();
  }

  List<ProfileSection> get sections => [
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
          id: 'history_viewed',
        ),
        MenuOption(
          title: "Deseos",
          subtitle: "guardados",
          icon: Icons.favorite_border,
          id: 'wishlist',
        ),
        MenuOption(
          title: "Cupones",
          subtitle: "",
          icon: Icons.card_giftcard,
          id: 'coupons',
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
          id: 'suggestions',
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

  void onOptionSelected(BuildContext context, MenuOption option) {
    if (option.route != null) {
      context.push(option.route!, extra: option.arguments);
      return;
    }

    if (option.id != null) {
      switch (option.id) {
        case 'suggestions':
          showSuggestionBottomSheet(context);
          break;
        case 'history_viewed':
          final activityViewModel = context.read<ActivityViewModel>();
          context.push(
            '/activity_products',
            extra: {
              'title': "Historial de Vistos",
              'products': activityViewModel.viewedProducts,
            },
          );
          break;
        case 'wishlist':
          final activityViewModel = context.read<ActivityViewModel>();
          context.push(
            '/activity_products',
            extra: {
              'title': "Mi Lista de Deseos",
              'products': activityViewModel.wishlistProducts,
            },
          );
          break;
        case 'coupons':
          context.push('/coupons');
          break;
      }
    }
  }

  void onSectionActionSelected(BuildContext context, ProfileSection section) {
    if (section.actionId == 'view_all_orders') {
      debugPrint("Ver todos los pedidos");
      // Example logic for "Ver todos"
    }
  }
}
