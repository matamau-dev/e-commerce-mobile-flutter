import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: const Center(child: Text("Menú de Categorías")),
          ),

          ListTile(
            leading: const Icon(Icons.sports_soccer),
            title: const Text("Playeras deportivas"),
            onTap: () {
              debugPrint("Playeras deportivas");
              context.push("/product_list", extra: "Playeras deportivas");
            },
          ),

          ExpansionTile(
            leading: const Icon(Icons.smartphone),
            title: const Text("Celulares"),
            childrenPadding: const EdgeInsets.only(left: 20),
            children: [
              ListTile(
                leading: const Icon(Icons.apple),
                title: const Text("iPhone"),
                onTap: () => context.push("/product_list", extra: "iPhone"),
              ),
              ExpansionTile(
                leading: const Icon(Icons.android),
                title: const Text("Android"),
                childrenPadding: const EdgeInsets.only(left: 20),
                children: [
                  ListTile(
                    title: const Text("Samsung"),
                    onTap: () =>
                        context.push("/product_list", extra: "Samsung"),
                  ),
                  ListTile(
                    title: const Text("Xiaomi"),
                    onTap: () => context.push("/product_list", extra: "Xiaomi"),
                  ),
                ],
              ),
            ],
          ),

          ListTile(
            leading: const Icon(Icons.computer),
            title: const Text("Computadoras"),
            onTap: () => context.push("/product_list", extra: "Computadoras"),
          ),
        ],
      ),
    );
  }
}
