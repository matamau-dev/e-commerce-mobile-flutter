import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminWrapper extends StatefulWidget {
  final Widget child;
  const AdminWrapper({super.key, required this.child});

  @override
  State<AdminWrapper> createState() => _AdminWrapperState();
}

class _AdminWrapperState extends State<AdminWrapper> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isActive(String route) {
    final String location = GoRouterState.of(context).uri.toString();
    return location.startsWith(route);
  }

  void _navigateTo(String route) {
    context.go(route);
    // 2. Usa la llave en lugar de Scaffold.of(context)
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _scaffoldKey.currentState
          ?.closeDrawer(); // Alternativa más directa que Navigator.pop
    }
  }

  // Widget optimizado para sub-ítems
  Widget _subMenuItem(String title, String route) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 72),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      selected: _isActive(route),
      onTap: () => _navigateTo(route),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Panel Administrativo"),
        backgroundColor: theme.colorScheme.surface,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () => debugPrint("Notificaciones"),
            icon: const Badge(
              label: Text("3"),
              child: Icon(Icons.notifications_outlined),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // --- SECCIÓN SUPERIOR ---
            UserAccountsDrawerHeader(
              accountName: const Text("Admin Principal"),
              accountEmail: const Text("admin@ecommerce.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
              ),
              decoration: BoxDecoration(color: theme.colorScheme.primary),
            ),

            // --- SECCIÓN CENTRAL (SCROLLABLE) ---
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.dashboard_outlined),
                    title: const Text('Dashboard'),
                    selected: _isActive('/dashboard'),
                    onTap: () => _navigateTo('/dashboard'),
                  ),

                  // Grupo Catálogo
                  ExpansionTile(
                    leading: const Icon(Icons.inventory_2_outlined),
                    title: const Text("Catálogo"),
                    initiallyExpanded:
                        _isActive('/products') ||
                        _isActive('/stocks') ||
                        _isActive('/categories') ||
                        _isActive("/brands") ||
                        _isActive("/models"),
                    children: [
                      _subMenuItem('Productos', '/products'),
                      _subMenuItem('Inventario', '/stocks'),
                      _subMenuItem('Categorías', '/categories'),
                      _subMenuItem('Marcas', '/brands'),
                      _subMenuItem('Modelos', '/models'),
                    ],
                  ),

                  // Grupo Ventas y Marketing
                  ExpansionTile(
                    leading: const Icon(Icons.point_of_sale),
                    title: const Text("Ventas"),
                    initiallyExpanded:
                        _isActive('/orders') ||
                        _isActive('/returns') ||
                        _isActive('/coupons'),
                    children: [
                      _subMenuItem('Pedidos', '/orders'),
                      _subMenuItem('Devoluciones', '/returns'),
                      _subMenuItem('Cupones', '/coupons'),
                    ],
                  ),

                  // Grupo Operaciones (Proveedores)
                  ExpansionTile(
                    leading: const Icon(Icons.business_outlined),
                    title: const Text("Operaciones"),
                    initiallyExpanded:
                        _isActive('/suppliers') ||
                        _isActive('/purchase-orders'),
                    children: [
                      _subMenuItem('Proveedores', '/suppliers'),
                      _subMenuItem('Abastecimiento', '/purchase-orders'),
                    ],
                  ),

                  ListTile(
                    leading: const Icon(Icons.people_outline),
                    title: const Text('Usuarios'),
                    selected: _isActive('/users'),
                    onTap: () => _navigateTo('/users'),
                  ),
                ],
              ),
            ),

            // --- SECCIÓN INFERIOR (FIJA) ---
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Configuración'),
              selected: _isActive('/settings'),
              onTap: () => _navigateTo('/settings'),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () => context.go('/login'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "v1.0.0 - Admin Panel",
                style: TextStyle(
                  color: theme.colorScheme.outline,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
      body: widget.child,
    );
  }
}
