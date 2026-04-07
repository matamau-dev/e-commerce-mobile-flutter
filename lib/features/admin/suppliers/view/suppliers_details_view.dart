import 'package:e_commerce/features/admin/suppliers/view/widgets/product_selection_modal.dart';
import 'package:e_commerce/features/admin/suppliers/view/widgets/suppliers_card.dart';
import 'package:e_commerce/features/admin/suppliers/view/widgets/suppliers_chip.dart';
import 'package:e_commerce/features/admin/suppliers/view/widgets/suppliers_contact.dart';
import 'package:e_commerce/presentation/images/custom_network_image.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuppliersDetailsView extends StatelessWidget {
  const SuppliersDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil del Proveedor"),
        actions: [
          IconButton(
            onPressed: () => context.push('/supplier-form?edit=true'),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CustomNetworkImage(
                    imageURL:
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                    height: 120,
                    width: 120,
                    borderRadius: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Proveedor XYZ",
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "ID: #SUP-2026",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildSectionTitle(context, "Información de Contacto"),
            const SizedBox(height: 8),
            SuppliersCard(
              widget: [
                SuppliersContact(
                  icon: Icons.email_outlined,
                  label: "Correo",
                  value: "example@gmail.com",
                  colors: colors,
                ),
                SuppliersContact(
                  icon: Icons.phone_outlined,
                  label: "Teléfono",
                  value: "+1234567890",
                  colors: colors,
                ),
                SuppliersContact(
                  icon: Icons.location_on_outlined,
                  label: "Dirección",
                  value: "123 Calle Principal, Ciudad",
                  colors: colors,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle(context, "Productos Suministrados"),
                IconButton(
                  onPressed: () => _showProductPicker(context),
                  icon: Icon(Icons.add_circle_outline, color: colors.primary),
                  tooltip: "Asociar Producto",
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SuppliersChip(label: "Producto A"),
                  SuppliersChip(label: "Producto B"),
                  SuppliersChip(label: "Producto C"),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: CustomButton(text: "Enviar Correo", onPressed: () {}),
                ),
                const SizedBox(width: 12),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline),
                  style: IconButton.styleFrom(foregroundColor: colors.error),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showProductPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const ProductSelectionModal(),
    );
  }
}
