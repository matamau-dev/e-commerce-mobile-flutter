import 'package:e_commerce/features/customer/home/view/home_drawer.dart';
import 'package:e_commerce/features/customer/home/view_model/home_view_model.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:e_commerce/presentation/widgets/cards/product_grid.dart';
import 'package:e_commerce/presentation/widgets/sliders/promo_slider.dart';
import 'package:e_commerce/presentation/widgets/text/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // ViewModel is provided by GoRouter shell
    final viewModel = context.watch<HomeViewModel>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.secondaryContainer.withAlpha(50),
        drawer: const HomeDrawer(),
        appBar: CustomAppBar(
          title: "Buscar",
          showSearchBar: true,
          onSearchChanged: viewModel.onSearchChanged,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: viewModel.onNotificationPressed,
            ),
          ],
        ),
        body: SafeArea(
          child: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SectionHeader(title: "Ofertas del dia"),
                      const SizedBox(height: 16),
                      PromoSlider(
                        images: [
                          'https://picsum.photos/seed/1/800/400',
                          'https://picsum.photos/seed/2/800/400',
                          'https://picsum.photos/seed/3/800/400',
                          'https://picsum.photos/seed/4/800/400',
                          'https://picsum.photos/seed/5/800/400',
                        ],
                      ),
                      const SizedBox(height: 16),
                      SectionHeader(title: "Productos destacados"),
                      const SizedBox(height: 16),
                      ProductGrid(
                        isScrollable: true,
                        products: viewModel.products,
                        onProductTap: (product) =>
                            viewModel.onProductSelected(context, product),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
