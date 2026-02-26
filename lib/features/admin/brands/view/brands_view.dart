import 'package:e_commerce/features/admin/brands/view/dialog/add_brands_dialog.dart';
import 'package:e_commerce/features/admin/brands/view/dialog/brands_form_dialog.dart';
import 'package:e_commerce/features/admin/brands/view/dialog/delete_brands_dialog.dart';
import 'package:e_commerce/features/admin/shared/widgets/admin_section.dart';
import 'package:e_commerce/features/admin/brands/view_model/brands_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandsView extends StatelessWidget {
  const BrandsView({super.key});

  @override
  Widget build(BuildContext context) {
    final brandViewModel = context.watch<BrandsViewModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _brandHeader(context),
              const SizedBox(height: 16),
              AdminSection(
                items: brandViewModel.brands,
                title: "Marcas",
                onEdit: (name) => _openBrandDialog(
                  context,
                  brandViewModel,
                  currentName: name,
                ),
                onDelete: (name) =>
                    _showDeleteDialog(context, brandViewModel, name),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onAddNewEntity(context, brandViewModel),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: const Icon(Icons.add, size: 28),
        label: const Text(
          'Nueva marca',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

Container _brandHeader(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      "Gestión de Marcas",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.underline,
        decorationThickness: 2,
      ),
    ),
  );
}

void _openBrandDialog(
  BuildContext context,
  BrandsViewModel vm, {
  String? currentName,
}) async {
  final result = await showDialog<String>(
    context: context,
    builder: (context) => BrandsFormDialog(
      title: currentName == null ? "Nueva Marca" : "Editar Marca",
      initialName: currentName,
    ),
  );

  if (result != null && currentName != null) {
    final String newName = result;
    vm.editBrand(currentName, newName);
  }
}

void _showDeleteDialog(
  BuildContext context,
  BrandsViewModel vm,
  String itemName,
) async {
  final shouldDelete = await showDialog<bool>(
    context: context,
    builder: (context) => DeleteBrandsDialog(itemName: itemName),
  );

  if (shouldDelete == true) {
    // Buscamos si es categoría o subcategoría y borramos
    if (vm.brands.contains(itemName)) {
      vm.deleteBrand(itemName);
    }
  }
}

void _onAddNewEntity(BuildContext context, BrandsViewModel vm) async {
  final result = await showDialog<String>(
    context: context,
    builder: (context) => AddBrandsDialog(brands: vm.brands),
  );

  debugPrint("result => $result");
  if (result != null) {
    final String name = result;

    debugPrint("name => $name");

    vm.addBrand(name);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$name guardado correctamente")));
  }
}
