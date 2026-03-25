import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuppliersFormView extends StatefulWidget {
  final bool isEditMode;
  const SuppliersFormView({super.key, this.isEditMode = false});

  @override
  State<SuppliersFormView> createState() => _SuppliersFormViewState();
}

class _SuppliersFormViewState extends State<SuppliersFormView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isEditMode ? "Editar Perfil" : "Nuevo Proveedor"),
          surfaceTintColor: Colors.transparent,
        ),
        body: Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader("Datos de Identidad"),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: "Nombre Comercial",
                  hint: "Ej: Distribuidora Global S.A.",
                  prefixIcon: Icons.business_rounded,
                  validator: (value) =>
                      value!.isEmpty ? "Campo requerido" : null,
                ),
                const SizedBox(height: 20),

                _buildSectionHeader("Contacto Directo"),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: "Teléfono",
                  hint: "55 1234 5678",
                  prefixIcon: Icons.phone_android_rounded,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                const CustomTextFormField(
                  label: "Correo Electrónico",
                  hint: "contacto@empresa.com",
                  prefixIcon: Icons.alternate_email_rounded,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                _buildSectionHeader("Ubicación"),
                const SizedBox(height: 16),
                const CustomTextFormField(
                  label: "Dirección Fiscal",
                  hint: "Calle, Número, Ciudad...",
                  prefixIcon: Icons.map_outlined,
                  maxLines: 2,
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomActions(),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: CustomButton(
        text: widget.isEditMode
            ? "Actualizar Proveedor"
            : "Registrar Proveedor",
        onPressed: () {
          context.push('/supplier-details');
        },
      ),
    );
  }
}
