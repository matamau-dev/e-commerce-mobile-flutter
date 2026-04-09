import 'package:e_commerce/features/customer/profile/domain/data/service/user_service.dart';
import 'package:e_commerce/features/customer/profile/domain/entities/user_entity.dart';
import 'package:e_commerce/features/customer/profile/domain/profile_action_enum.dart';
import 'package:e_commerce/features/customer/profile/view/profile_menu_config.dart';
import 'package:e_commerce/features/exceptions/api_exception.dart';
import 'package:e_commerce/features/models/process_result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/features/customer/profile/domain/data/models/profile_models.dart';
import 'package:e_commerce/features/customer/profile/domain/data/models/user_model.dart';
import 'package:e_commerce/features/customer/profile/view_model/activity_view_model.dart';
import 'package:e_commerce/features/customer/profile/widget/suggestion_bottom_sheet.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ProfileSection> get sections => ProfileMenuConfig.getSections();

  Future<ProcessResult> loadUserProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _userService.getUserProfile();
      print('DATA $data');
      final userEntity = UserEntity(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        phone: data['phone'],
        imageUrl: data['imageUrl'] ?? 'https://i.pravatar.cc/300',
      );

      _user = UserModel.fromEntity(userEntity);
      return ProcessResult.ok();
    } on ApiException catch (e) {
      return ProcessResult.failure(e.message);
    } catch (e) {
      return ProcessResult.failure('Ocurrió un error inesperado');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onOptionSelected(BuildContext context, MenuOption option) {
    if (option.route != null) {
      context.push(option.route!, extra: option.arguments);
      return;
    }

    if (option.id is ProfileOptionId) {
      _executeSpecialAction(context, option.id as ProfileOptionId);
    }
  }

  void _executeSpecialAction(BuildContext context, ProfileOptionId actionId) {
    final activityVM = context.read<ActivityViewModel>();

    final Map<ProfileOptionId, VoidCallback> actions = {
      ProfileOptionId.suggestions: () => _showSuggestions(context),
      ProfileOptionId.coupons: () => context.push('/coupons'),
      ProfileOptionId.historyViewed: () =>
          _navToActivity(context, "Historial", activityVM.viewedProducts),
      ProfileOptionId.wishlist: () => _navToActivity(
        context,
        "Mi Lista de Deseos",
        activityVM.wishlistProducts,
      ),
    };

    actions[actionId]?.call();
  }

  void _navToActivity(BuildContext context, String title, List products) {
    context.push(
      '/activity_products',
      extra: {'title': title, 'products': products},
    );
  }

  void _showSuggestions(BuildContext context) {
    showSuggestionBottomSheet(context);
  }
}
