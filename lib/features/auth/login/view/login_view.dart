import 'package:e_commerce/features/auth/login/view_model/login_view_model.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:e_commerce/presentation/widgets/buttons/button_type.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:e_commerce/presentation/widgets/inputs/password_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();
    return Scaffold(
      appBar: CustomAppBar(title: "Bienvenido", centerTitle: true),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: loginViewModel.formKeyLogin,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        "Inicia Sesión Para Continuar",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Image.asset("assets/images/logo.png", height: 250),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      label: "Correo o Nombre de usuario",
                      hint: "ej:example@gmail.com/exp",
                      controller: loginViewModel.loginController,
                      prefixIcon: Icons.person_2,
                      validator: loginViewModel.validateLogin,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        loginViewModel.loginFocusNode.unfocus();
                        loginViewModel.passwordFocusNode.requestFocus();
                      },
                    ),

                    const SizedBox(height: 20),
                    PasswordInput(
                      label: "Contraseña",
                      hint: "* * * * * *",
                      validator: loginViewModel.validatePassword,
                      controller: loginViewModel.passwordController,
                      focusNode: loginViewModel.passwordFocusNode,
                      onSubmitted: (_) async {
                        loginViewModel.passwordFocusNode.unfocus();
                        final success = await loginViewModel.onFormSubmit();
                        if (success && context.mounted) {
                          context.push("/home");
                        }
                      },
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: loginViewModel.isLoading
                            ? "Espere..."
                            : "Iniciar Sesión",
                        onPressed: () async {
                          final success = await loginViewModel.onFormSubmit();
                          if (success && context.mounted) {
                            context.push("/home");
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: loginViewModel.isLoading
                            ? "Espere..."
                            : "Login admin",
                        onPressed: () async {
                          final success = await loginViewModel.onFormSubmit();
                          if (success && context.mounted) {
                            context.push("/dashboard");
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "¿No tienes cuenta?",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(width: 4),
                        CustomButton(
                          text: "Registrate AQUI!!",
                          buttonType: ButtonType.textButton,
                          onPressed: () {
                            context.push("/register");
                          },
                        ),
                      ],
                    ),
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
