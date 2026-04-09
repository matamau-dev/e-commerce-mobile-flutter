import 'package:e_commerce/features/providers/auth_provider.dart';
import 'package:e_commerce/presentation/wrappers/admin_wrapper.dart';
import 'package:e_commerce/presentation/wrappers/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'auth_redirect.dart';
import 'modules/auth_routes.dart';
import 'modules/admin_routes.dart';
import 'modules/main_routes.dart';

class AppRouter {
  final AuthProvider authProvider;

  final _rootKey = GlobalKey<NavigatorState>();
  final _adminKey = GlobalKey<NavigatorState>();
  final _mainKey = GlobalKey<NavigatorState>();

  AppRouter(this.authProvider);

  late final router = GoRouter(
    navigatorKey: _rootKey,
    refreshListenable: authProvider,
    initialLocation: '/',
    redirect: (context, state) =>
        AuthRedirect.call(state, authProvider.isAuthenticated),
    routes: [
      ...AuthRoutes.routes,

      ShellRoute(
        navigatorKey: _adminKey,
        builder: (context, state, child) => AdminWrapper(child: child),
        routes: AdminRoutes.routes,
      ),

      ShellRoute(
        navigatorKey: _mainKey,
        builder: (context, state, child) => MainWrapper(child: child),
        routes: MainRoutes.routes,
      ),
    ],
  );
}
