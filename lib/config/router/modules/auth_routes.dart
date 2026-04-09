import 'package:e_commerce/features/auth/login/data/service/login_service.dart';
import 'package:e_commerce/features/auth/login/view/login_view.dart';
import 'package:e_commerce/features/auth/login/view_model/login_view_model.dart';
import 'package:e_commerce/features/auth/register/view/register_view.dart';
import 'package:e_commerce/features/auth/register/view_model/register_view_model.dart';
import 'package:e_commerce/features/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../route_helpers.dart';
import '../route_paths.dart';

class AuthRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (context) =>
            LoginViewModel(LoginService(), context.read<AuthProvider>()),
        child: const LoginView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.register,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (context) => RegisterViewModel(),
        child: const RegisterView(),
      ),
    ),
  ];
}
