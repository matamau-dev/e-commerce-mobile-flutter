import 'package:e_commerce/features/customer/payment/domain/brand.dart';
import 'package:e_commerce/features/customer/payment/model/card_payment.dart';
import 'package:e_commerce/features/customer/payment/view_model/payments_view_model.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddCardView extends StatefulWidget {
  final CardPayment? cardToEdit;

  const AddCardView({super.key, this.cardToEdit});

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _nameController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  bool get isEditing => widget.cardToEdit != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      final card = widget.cardToEdit!;
      _numberController.text = card.hiddenNumber;
      _nameController.text = card.cardHolderName;
      _expiryController.text = card.expirationDate;
      _cvvController.text = "***"; // Mock CVV
    }
  }

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      // Simple parse logic for demo
      final expiry = _expiryController.text.split('/');
      final month = expiry.isNotEmpty ? expiry[0] : "00";
      final year = expiry.length > 1 ? expiry[1] : "00";

      if (isEditing) {
        final updatedCard = widget.cardToEdit!.copyWith(
          cardHolderName: _nameController.text.toUpperCase(),
          expMonth: month,
          expYear: year,
        );
        context.read<PaymentsViewModel>().updateCard(updatedCard);
      } else {
        final number = _numberController.text.replaceAll(' ', '');
        final last4 = number.length >= 4
            ? number.substring(number.length - 4)
            : "0000";

        // Detect brand (simple mock logic)
        Brand brand = Brand.other;
        if (number.startsWith('4'))
          brand = Brand.visa;
        else if (number.startsWith('5'))
          brand = Brand.mastercard;
        else if (number.startsWith('3'))
          brand = Brand.amex;

        final newCard = CardPayment(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          cardHolderName: _nameController.text.toUpperCase(),
          last4: last4,
          expMonth: month,
          expYear: year,
          brand: brand,
          active: false,
        );
        context.read<PaymentsViewModel>().addCard(newCard);
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: isEditing ? "Editar Tarjeta" : "Agregar Tarjeta",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                label: "Número de tarjeta",
                controller: _numberController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.credit_card,
                readOnly: isEditing,
                enabled: !isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa el número de tarjeta";
                  }
                  if (!isEditing && value.length < 16) {
                    return "Número inválido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: "Nombre del titular",
                controller: _nameController,
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa el nombre del titular";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: "Expiración (MM/YY)",
                      controller: _expiryController,
                      keyboardType: TextInputType.datetime,
                      prefixIcon: Icons.calendar_today,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('/')) {
                          return "Inválido";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextFormField(
                      label: "CVV",
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      readOnly: isEditing,
                      enabled: !isEditing,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return "Inválido";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: isEditing ? "Actualizar Tarjeta" : "Guardar Tarjeta",
                  onPressed: _saveCard,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
