import 'package:e_commerce/features/admin/brands/view/brands_view.dart';
import 'package:e_commerce/features/admin/brands/view_model/brands_view_model.dart';
import 'package:e_commerce/features/admin/category/view/category_schema_editor_view.dart';
import 'package:e_commerce/features/admin/category/view/category_view.dart';
import 'package:e_commerce/features/admin/category/view_model/category_schema_editor_view_model.dart';
import 'package:e_commerce/features/admin/category/view_model/category_view_model.dart';
import 'package:e_commerce/features/admin/dashboard/view/dashboard_view.dart';
import 'package:e_commerce/features/admin/dashboard/view_model/dashboard_view_model.dart';
import 'package:e_commerce/features/admin/product/view/product_admin.dart';
import 'package:e_commerce/features/admin/product/view/product_form_view.dart';
import 'package:e_commerce/features/admin/product/view_model/product_admin_view_model.dart';
import 'package:e_commerce/features/admin/product_line/view/product_line_view.dart';
import 'package:e_commerce/features/admin/product_line/view_model/product_line_view_model.dart';
import 'package:e_commerce/features/admin/suppliers/view/suppliers_details_view.dart';
import 'package:e_commerce/features/admin/suppliers/view/suppliers_form_view.dart';
import 'package:e_commerce/features/admin/suppliers/view/suppliers_view.dart';
import 'package:e_commerce/features/admin/suppliers/view_model/suppliers_view_model.dart';
import 'package:e_commerce/features/admin/supply/view/new_supply_view.dart';
import 'package:e_commerce/features/admin/supply/view/supply_view.dart';
import 'package:e_commerce/features/admin/supply/view_model/supply_view_model.dart';
import 'package:go_router/go_router.dart';
import '../route_helpers.dart';
import '../route_paths.dart';

class AdminRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: RoutePaths.dashboard,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => DashboardViewModel(),
        child: const Dashboard(),
      ),
    ),
    GoRoute(
      path: RoutePaths.products,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => ProductAdminViewModel(),
        child: const ProductAdmin(),
      ),
    ),
    GoRoute(
      path: RoutePaths.productForm,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => ProductAdminViewModel(),
        child: const ProductFormView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.categories,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => CategoryViewModel(),
        child: const CategoryView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.newCategory,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => CategorySchemaEditorViewModel(),
        child: const CategorySchemaEditorView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.brands,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => BrandsViewModel(),
        child: const BrandsView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.models,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => ProductLineViewModel(),
        child: const ProductLineView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.suppliers,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => SuppliersViewModel(),
        child: const SuppliersView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.supplierDetails,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => SuppliersViewModel(),
        child: SuppliersDetailsView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.supplierForm,
      builder: (context, state) {
        final isEdit = state.uri.queryParameters['edit'] == 'true';
        return RouteHelpers.withProvider(
          create: (_) => SuppliersViewModel(),
          child: SuppliersFormView(isEditMode: isEdit),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.purchaseOrders,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => SupplyViewModel(),
        child: SupplyView(),
      ),
    ),
    GoRoute(
      path: RoutePaths.newSupply,
      builder: (context, state) => RouteHelpers.withProvider(
        create: (_) => SupplyViewModel(),
        child: NewSupplyView(),
      ),
    ),
  ];
}
