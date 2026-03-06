import 'package:e_commerce/features/admin/brands/view/brands_view.dart';
import 'package:e_commerce/features/admin/brands/view_model/brands_view_model.dart';
import 'package:e_commerce/features/admin/category/view/category.dart';
import 'package:e_commerce/features/admin/category/view_model/category_view_model.dart';
import 'package:e_commerce/features/admin/product/view/product_admin.dart';
import 'package:e_commerce/features/admin/product/view_model/product_admin_view_model.dart';
import 'package:e_commerce/features/admin/product_line/view/product_line_view.dart';
import 'package:e_commerce/features/admin/product_line/view_model/product_line_view_model.dart';
import 'package:e_commerce/features/customer/address/view/addresses_view.dart';
import 'package:e_commerce/features/customer/address/view_model/address_view_model.dart';
import 'package:e_commerce/features/admin/dashboard/view/dashboard_view.dart';
import 'package:e_commerce/features/admin/dashboard/view_model/dashboard_view_model.dart';
import 'package:e_commerce/features/customer/checkout/view/checkout_view.dart';
import 'package:e_commerce/features/customer/checkout/view_model/checkout_view_model.dart';
import 'package:e_commerce/features/customer/profile/domain/models/activity_models.dart';
import 'package:e_commerce/features/customer/profile/view/activity_products_view.dart';
import 'package:e_commerce/features/customer/profile/view/coupons_view.dart';
import 'package:e_commerce/features/customer/profile/view/help_support_view.dart';
import 'package:e_commerce/features/customer/profile/view/legal_view.dart';
import 'package:e_commerce/features/customer/profile/view/edit_profile_view.dart';
import 'package:e_commerce/features/customer/profile/view_model/activity_view_model.dart';
import 'package:e_commerce/features/auth/login/view/login_view.dart';
import 'package:e_commerce/features/auth/login/view_model/login_view_model.dart';
import 'package:e_commerce/features/auth/register/view/register_view.dart';
import 'package:e_commerce/features/auth/register/view_model/register_view_model.dart';
import 'package:e_commerce/features/customer/cart/view/cart_view.dart';
import 'package:e_commerce/features/customer/cart/view_model/cart_view_model.dart';
import 'package:e_commerce/features/customer/home/view/home_view.dart';
import 'package:e_commerce/features/customer/home/view_model/home_view_model.dart';
import 'package:e_commerce/features/customer/payment/view/payments_view.dart';
import 'package:e_commerce/features/customer/payment/view_model/payments_view_model.dart';
import 'package:e_commerce/features/customer/product/view/product_view.dart';
import 'package:e_commerce/features/customer/product/view_model/product_view_model.dart';
import 'package:e_commerce/features/customer/products/view/product_list_view.dart';
import 'package:e_commerce/features/customer/products/view_model/product_list_view_model.dart';
import 'package:e_commerce/features/customer/profile/view/profile_view.dart';
import 'package:e_commerce/features/customer/profile/domain/models/order_model.dart';
import 'package:e_commerce/features/customer/profile/view/order_detail_view.dart';
import 'package:e_commerce/features/customer/profile/view/orders_view.dart';
import 'package:e_commerce/features/customer/profile/view_model/order_view_model.dart';
import 'package:e_commerce/features/customer/profile/view_model/profile_view_model.dart';
import 'package:e_commerce/features/customer/settings/view/settings_view.dart';
import 'package:e_commerce/features/customer/settings/view_model/settings_view_model.dart';

import 'package:e_commerce/features/customer/store/view/store_view.dart';
import 'package:e_commerce/presentation/wrappers/admin_wrapper.dart';
import 'package:e_commerce/presentation/wrappers/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _adminNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/register',
      builder: (context, state) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => RegisterViewModel()),
          ],
          child: const RegisterView(),
        );
      },
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LoginViewModel()),
          ],
          child: const LoginView(),
        );
      },
    ),
    ShellRoute(
      navigatorKey: _adminNavigatorKey,
      builder: (context, state, child) {
        return AdminWrapper(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => DashboardViewModel(),
                ),
              ],
              child: const Dashboard(),
            );
          },
        ),
        GoRoute(
          path: '/products',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ProductAdminViewModel(),
                ),
              ],
              child: const ProductAdmin(),
            );
          },
        ),
        GoRoute(
          path: '/categories',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => CategoryViewModel(),
                ),
              ],
              child: const CategoryView(),
            );
          },
        ),
        GoRoute(
          path: '/brands',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => BrandsViewModel()),
              ],
              child: const BrandsView(),
            );
          },
        ),
        GoRoute(
          path: '/models',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ProductLineViewModel(),
                ),
              ],
              child: const ProductLineView(),
            );
          },
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,

      builder: (context, state, child) {
        return MainWrapper(child: child);
      },

      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => HomeViewModel()),
              ],
              child: const HomeView(),
            );
          },
        ),
        GoRoute(
          path: '/store',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ProductListViewModel("Todos"),
                ),
              ],
              child: const StoreView(),
            );
          },
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => CartViewModel()),
              ],
              child: const CartView(),
            );
          },
        ),
        GoRoute(
          path: '/edit_profile',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: context.read<ProfileViewModel>(),
                ),
              ],
              child: const EditProfileView(),
            );
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => ProfileViewModel()),
              ],
              child: const ProfileView(),
            );
          },
        ),
        GoRoute(
          path: '/product',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ProductViewModel(
                    context.read<ActivityViewModel>(),
                    context.read<CartViewModel>(),
                  ),
                ),
              ],
              child: ProductView(),
            );
          },
        ),
        GoRoute(
          path: '/product_list',
          builder: (context, state) {
            final categoryData = state.extra as String? ?? "Sin categoría";
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ProductListViewModel(categoryData),
                ),
              ],
              child: ProductListView(category: categoryData),
            );
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => SettingsViewModel(),
                ),
              ],
              child: const SettingsView(),
            );
          },
        ),
        GoRoute(
          path: '/payments',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => PaymentsViewModel(),
                ),
              ],
              child: const PaymentsView(),
            );
          },
        ),
        GoRoute(
          path: '/addresses',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => AddressViewModel()),
              ],
              child: const AddressesView(),
            );
          },
        ),
        GoRoute(
          path: '/orders',
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>? ?? {};
            final filterStatuses =
                extras['filterStatuses'] as List<OrderStatus>? ?? [];
            final title = extras['title'] as String? ?? "Mis Pedidos";

            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => OrderViewModel()),
              ],
              child: OrdersView(filterStatuses: filterStatuses, title: title),
            );
          },
        ),
        GoRoute(
          path: '/order_detail',
          builder: (context, state) {
            final order = state.extra as OrderModel;
            return OrderDetailView(order: order);
          },
        ),
        GoRoute(
          path: '/activity_products',
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;
            final title = extras['title'] as String;
            final products = extras['products'] as List<ActivityProduct>;
            return ActivityProductsView(title: title, products: products);
          },
        ),
        GoRoute(
          path: '/coupons',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ActivityViewModel(),
                ),
              ],
              child: const CouponsView(),
            );
          },
        ),
        GoRoute(
          path: '/help',
          builder: (context, state) {
            return const HelpSupportView();
          },
        ),
        GoRoute(
          path: '/legal',
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;
            final title = extras['title'] as String;
            final type = extras['type'] as String;
            return LegalView(title: title, type: type);
          },
        ),
        GoRoute(
          path: '/checkout',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => CheckoutViewModel(
                    context.read<CartViewModel>(),
                    context.read<AddressViewModel>(),
                    context.read<PaymentsViewModel>(),
                  ),
                ),
              ],
              child: const CheckoutView(),
            );
          },
        ),
      ],
    ),
  ],
);
