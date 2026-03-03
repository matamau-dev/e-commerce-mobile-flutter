import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainWrapper extends StatefulWidget {
  final Widget child;

  const MainWrapper({super.key, required this.child});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/store');
        break;
      case 2:
        context.go('/cart');
        break;
      case 3:
        context.go('/profile');
        break;
      case 4:
        context.go('/login');
        break;
    }
  }

  void _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) {
      _selectedIndex = 0;
    } else if (location.startsWith('/store')) {
      _selectedIndex = 1;
    } else if (location.startsWith('/cart')) {
      _selectedIndex = 2;
    } else if (location.startsWith('/profile')) {
      _selectedIndex = 3;
    } else if (location.startsWith('/login')) {
      _selectedIndex = 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    _calculateSelectedIndex(context);

    return Scaffold(
      body: widget.child,

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Tienda',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
          NavigationDestination(
            icon: Icon(Icons.logout_outlined),
            selectedIcon: Icon(Icons.logout),
            label: 'Cerrar Sesión',
          ),
        ],
      ),
    );
  }
}
