import 'package:e_commerce/features/auth/register/view_model/register_view_model.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:e_commerce/presentation/widgets/inputs/password_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: "Crear Cuenta"),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: registerViewModel.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    Text(
                      "Ingresa tus datos para comenzar",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),

                    const SizedBox(height: 32),

                    CustomTextFormField(
                      label: "Nombre completo",
                      hint: "Ej. Juan Pérez",
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.person_outline,
                      controller: registerViewModel.nameController,
                      validator: registerViewModel.validateName,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        registerViewModel.nameFocusNode.unfocus();
                        registerViewModel.usernameFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      label: "Usuario",
                      hint: "Ej. juanperez",
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.person_outline,
                      controller: registerViewModel.usernameController,
                      validator: registerViewModel.validateUsername,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        registerViewModel.usernameFocusNode.unfocus();
                        registerViewModel.emailFocusNode.requestFocus();
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomTextFormField(
                      label: "Correo Electrónico",
                      hint: "usuario@email.com",
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      controller: registerViewModel.emailController,
                      validator: registerViewModel.validateEmail,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        registerViewModel.emailFocusNode.unfocus();
                        registerViewModel.passwordFocusNode.requestFocus();
                      },
                    ),

                    const SizedBox(height: 20),

                    PasswordInput(
                      label: "Contraseña",
                      hint: "Mínimo 6 caracteres",
                      controller: registerViewModel.passwordController,
                      validator: registerViewModel.validatePassword,
                      focusNode: registerViewModel.passwordFocusNode,
                      onSubmitted: (_) {
                        registerViewModel.passwordFocusNode.unfocus();
                        registerViewModel.confirmPasswordFocusNode
                            .requestFocus();
                      },
                    ),

                    const SizedBox(height: 20),

                    PasswordInput(
                      label: "Confirmar contraseña",
                      hint: "Repite tu contraseña",
                      controller: registerViewModel.confirmPasswordController,
                      validator: registerViewModel.validateConfirmPassword,
                      focusNode: registerViewModel.confirmPasswordFocusNode,
                      onSubmitted: (_) async {
                        registerViewModel.confirmPasswordFocusNode.unfocus();
                        final success = await registerViewModel.onFormSubmit();
                        if (success && context.mounted) {
                          context.push("/login");
                        }
                      },
                    ),

                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: registerViewModel.isLoading
                            ? "Espere..."
                            : "Registrarse",
                        icon: Icons.arrow_forward,
                        isIconRight: true,
                        onPressed: registerViewModel.isLoading
                            ? null
                            : () async {
                                final success = await registerViewModel
                                    .onFormSubmit();
                                if (success && context.mounted) {
                                  context.push("/login");
                                }
                              },
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("¿Ya tienes cuenta?"),
                        TextButton(
                          onPressed: () {
                            context.push('/login');
                          },
                          child: const Text("Inicia Sesión"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
