import 'package:e_commerce/features/customer/settings/view_model/change_password_view_model.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:e_commerce/presentation/widgets/inputs/password_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ChangePasswordViewModel>(context);

    return PopScope(
      canPop: !vm.isLoading,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              AbsorbPointer(
                absorbing: vm.isLoading,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: vm.formKey,
                        child: _StepContent(vm: vm),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (vm.currentStep > 0)
                            TextButton(
                              onPressed: vm.previousStep,
                              child: const Text('Atrás'),
                            ),
                          const SizedBox(width: 8),
                          if (vm.currentStep == 0)
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancelar'),
                            ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              if (vm.currentStep == 2) {
                                final success = await vm.onFormSubmit();
                                if (context.mounted && success) {
                                  Navigator.of(context).pop();
                                }
                              } else {
                                vm.nextStep();
                              }
                            },
                            child: Text(
                              vm.currentStep == 2 ? 'Guardar' : 'Siguiente',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (vm.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepContent extends StatelessWidget {
  final ChangePasswordViewModel vm;
  const _StepContent({required this.vm});

  @override
  Widget build(BuildContext context) {
    switch (vm.currentStep) {
      case 0:
        return Column(
          children: [
            const Text(
              'Recuperación de Cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Ingrese su correo para recibir un código.'),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: "Correo electrónico",
              hint: "ejemplo@gmail.com",
              keyboardType: TextInputType.emailAddress,
              validator: vm.validateEmail,
              controller: vm.emailController,
            ),
          ],
        );
      case 1:
        return Column(
          children: [
            const Text(
              'Verificación',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Ingrese el código de 6 dígitos.'),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: "Código OTP",
              hint: "123456",
              keyboardType: TextInputType.number,
              validator: vm.validateOtp,
              controller: vm.otpController,
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            const Text(
              'Nueva Contraseña',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            PasswordInput(
              label: "Nueva contraseña",
              hint: "********",
              validator: vm.validatePassword,
              controller: vm.passwordController,
            ),
            const SizedBox(height: 12),
            PasswordInput(
              label: "Confirmar contraseña",
              hint: "********",
              validator: vm.validateConfirmPassword,
              controller: vm.confirmPasswordController,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
