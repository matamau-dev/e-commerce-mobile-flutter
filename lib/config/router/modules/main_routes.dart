import 'package:e_commerce/features/customer/address/view_model/address_view_model.dart';
import 'package:e_commerce/features/customer/cart/view/cart_view.dart';
import 'package:e_commerce/features/customer/cart/view_model/cart_view_model.dart';
import 'package:e_commerce/features/customer/checkout/view/checkout_view.dart';
import 'package:e_commerce/features/customer/checkout/view_model/checkout_view_model.dart';
import 'package:e_commerce/features/customer/home/view/home_view.dart';
import 'package:e_commerce/features/customer/home/view_model/home_view_model.dart';
import 'package:e_commerce/features/customer/payment/view_model/payments_view_model.dart';
import 'package:e_commerce/features/customer/product/view/product_view.dart';
import 'package:e_commerce/features/customer/product/view_model/product_view_model.dart';
import 'package:e_commerce/features/customer/products/view/product_list_view.dart';
import 'package:e_commerce/features/customer/products/view_model/product_list_view_model.dart';
import 'package:e_commerce/features/customer/profile/view/edit_profile_view.dart';
import 'package:e_commerce/features/customer/profile/view/profile_view.dart';
import 'package:e_commerce/features/customer/profile/view_model/activity_view_model.dart';
import 'package:e_commerce/features/customer/profile/view_model/profile_view_model.dart';
import 'package:e_commerce/features/customer/store/view/store_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../route_helpers.dart';
import '../route_paths.dart';

class MainRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => HomeViewModel(),
        child: const HomeView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.store,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => ProductListViewModel("Todos"),
        child: const StoreView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.cart,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => CartViewModel(),
        child: const CartView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.profile,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => ProfileViewModel(),
        child: const ProfileView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.editProfile,
      builder: (context, state) => RouteHelpers.withValueProvider(
        value: context.read<ProfileViewModel>(),
        child: const EditProfileView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.product,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (context) => ProductViewModel(
          context.read<ActivityViewModel>(),
          context.read<CartViewModel>(),
        ),
        child: ProductView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.productList,
      builder: (context, state) {
        final category = state.extra as String? ?? "Sin categoría";
        return RouteHelpers.withProvider(
          create: (_) => ProductListViewModel(category),
          child: ProductListView(category: category),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.checkout,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (context) => CheckoutViewModel(
          context.read<CartViewModel>(),
          context.read<AddressViewModel>(),
          context.read<PaymentsViewModel>(),
        ),
        child: const CheckoutView(),
      ),
    ),
  ];
}
