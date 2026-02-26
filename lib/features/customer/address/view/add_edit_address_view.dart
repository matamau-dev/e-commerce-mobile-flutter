import 'package:e_commerce/features/customer/address/model/address_model.dart';
import 'package:e_commerce/features/customer/address/view_model/address_view_model.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddEditAddressView extends StatefulWidget {
  final AddressModel? addressToEdit;

  const AddEditAddressView({super.key, this.addressToEdit});

  @override
  State<AddEditAddressView> createState() => _AddEditAddressViewState();
}

class _AddEditAddressViewState extends State<AddEditAddressView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _extNumController = TextEditingController();
  final _intNumController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();

  bool get isEditing => widget.addressToEdit != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      final address = widget.addressToEdit!;
      _nameController.text = address.name;
      _streetController.text = address.street;
      _extNumController.text = address.exteriorNumber;
      _intNumController.text = address.interiorNumber ?? "";
      _cityController.text = address.city;
      _stateController.text = address.state;
      _zipController.text = address.zipCode;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _extNumController.dispose();
    _intNumController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      if (isEditing) {
        final updatedAddress = widget.addressToEdit!.copyWith(
          name: _nameController.text,
          street: _streetController.text,
          exteriorNumber: _extNumController.text,
          interiorNumber: _intNumController.text.isNotEmpty
              ? _intNumController.text
              : null,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipController.text,
        );
        context.read<AddressViewModel>().updateAddress(updatedAddress);
      } else {
        final newAddress = AddressModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: _nameController.text,
          street: _streetController.text,
          exteriorNumber: _extNumController.text,
          interiorNumber: _intNumController.text.isNotEmpty
              ? _intNumController.text
              : null,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipController.text,
          isDefault: false,
        );
        context.read<AddressViewModel>().addAddress(newAddress);
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: isEditing ? "Editar Dirección" : "Nueva Dirección",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                label: "Nombre (Ej: Casa, Trabajo)",
                controller: _nameController,
                prefixIcon: Icons.label_outline,
                validator: (v) => v!.isEmpty ? "Requerido" : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: "Calle",
                controller: _streetController,
                prefixIcon: Icons.map_outlined,
                validator: (v) => v!.isEmpty ? "Requerido" : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: "No. Ext",
                      controller: _extNumController,
                      validator: (v) => v!.isEmpty ? "Requerido" : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextFormField(
                      label: "No. Int (Opcional)",
                      controller: _intNumController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: "Ciudad",
                      controller: _cityController,
                      validator: (v) => v!.isEmpty ? "Requerido" : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextFormField(
                      label: "Estado",
                      controller: _stateController,
                      validator: (v) => v!.isEmpty ? "Requerido" : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: "Código Postal",
                controller: _zipController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.local_post_office_outlined,
                validator: (v) => v!.isEmpty ? "Requerido" : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: isEditing
                      ? "Actualizar Dirección"
                      : "Guardar Dirección",
                  onPressed: _saveAddress,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
