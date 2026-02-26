import 'package:e_commerce/features/customer/profile/view_model/activity_view_model.dart';
import 'package:e_commerce/features/customer/profile/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/config/router/app_router.dart';
import 'package:e_commerce/config/theme/app_theme.dart';

// Importa tus ViewModels
import 'package:e_commerce/features/customer/cart/view_model/cart_view_model.dart';
import 'package:e_commerce/features/customer/address/view_model/address_view_model.dart';
import 'package:e_commerce/features/customer/payment/view_model/payments_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => AddressViewModel()),
        ChangeNotifierProvider(create: (_) => PaymentsViewModel()),
        ChangeNotifierProvider(create: (_) => ActivityViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: MaterialApp.router(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      ),
    );
  }
}
