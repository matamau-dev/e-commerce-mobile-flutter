import 'package:e_commerce/features/customer/profile/view_model/activity_view_model.dart';
import 'package:e_commerce/features/customer/profile/view_model/profile_view_model.dart';
import 'package:e_commerce/features/http/api_client.dart';
import 'package:e_commerce/features/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/config/router/app_router.dart';
import 'package:e_commerce/config/theme/app_theme.dart';

import 'package:e_commerce/features/customer/cart/view_model/cart_view_model.dart';
import 'package:e_commerce/features/customer/address/view_model/address_view_model.dart';
import 'package:e_commerce/features/customer/payment/view_model/payments_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();
  await authProvider.checkAuth();
  ApiClient.init(authProvider);

  final appRouter = AppRouter(authProvider).router;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),

        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => AddressViewModel()),
        ChangeNotifierProvider(create: (_) => PaymentsViewModel()),
        ChangeNotifierProvider(create: (_) => ActivityViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: MyApp(router: appRouter),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
