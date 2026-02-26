import 'package:e_commerce/features/admin/category/view/dialog/add_category_dialog.dart';
import 'package:e_commerce/features/admin/category/view/dialog/category_form_dialog.dart';
import 'package:e_commerce/features/admin/category/view/dialog/delete_confirm_dialog.dart';
import 'package:e_commerce/features/admin/shared/widgets/admin_section.dart';
import 'package:e_commerce/features/admin/category/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryViewModel = context.watch<CategoryViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _categoryHeader(context),
              const SizedBox(height: 16),
              AdminSection(
                items: categoryViewModel.categories,
                title: "Categorias",
                onEdit: (name) => _openCategoryDialog(
                  context,
                  categoryViewModel,
                  currentName: name,
                  isSub: false,
                ),
                onDelete: (name) =>
                    _showDeleteDialog(context, categoryViewModel, name),
              ),
              const SizedBox(height: 16),
              AdminSection(
                items: categoryViewModel.subCategories,
                title: "Sub Categorias",
                onEdit: (name) => _openCategoryDialog(
                  context,
                  categoryViewModel,
                  currentName: name,
                  isSub: true,
                ),
                onDelete: (name) =>
                    _showDeleteDialog(context, categoryViewModel, name),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onAddNewEntity(context, categoryViewModel),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: const Icon(Icons.add, size: 28),
        label: const Text(
          'Nueva categoría',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Container _categoryHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "Gestión de Categorias",
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
}

void _openCategoryDialog(
  BuildContext context,
  CategoryViewModel vm, {
  String? currentName,
  required bool isSub,
}) async {
  final result = await showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) => CategoryFormDialog(
      title: currentName == null ? "Nueva Categoría" : "Editar Categoría",
      initialName: currentName,
      isSubCategory: isSub,
      categories: vm.categories,
    ),
  );

  if (result != null && currentName != null) {
    final String newName = result['name'];
    if (isSub) {
      vm.editSubCategory(currentName, newName);
    } else {
      vm.editCategory(currentName, newName);
    }
  }
}

void _showDeleteDialog(
  BuildContext context,
  CategoryViewModel vm,
  String itemName,
) async {
  final shouldDelete = await showDialog<bool>(
    context: context,
    builder: (context) => DeleteConfirmDialog(itemName: itemName),
  );

  if (shouldDelete == true) {
    // Buscamos si es categoría o subcategoría y borramos
    if (vm.categories.contains(itemName)) {
      vm.deleteCategory(itemName);
    } else {
      vm.deleteSubCategory(itemName);
    }
  }
}

void _onAddNewEntity(BuildContext context, CategoryViewModel vm) async {
  final result = await showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) => AddCategoryDialog(categories: vm.categories),
  );

  debugPrint("result => $result");
  if (result != null) {
    final bool isSub = result['isSub'];
    final String name = result['name'];
    final String? parent = result['parent'];

    debugPrint("name => $name");
    debugPrint("parent => $parent");
    debugPrint("isSub => $isSub");

    if (isSub) {
      vm.addSubCategory(name);
    } else {
      vm.addCategory(name);
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$name guardado correctamente")));
  }
}
