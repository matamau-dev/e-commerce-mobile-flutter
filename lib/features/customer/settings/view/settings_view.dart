import 'package:e_commerce/features/customer/settings/domain/settings_enums.dart';
import 'package:e_commerce/features/customer/settings/view_model/change_password_view_model.dart';
import 'package:e_commerce/features/customer/settings/view_model/settings_view_model.dart';
import 'package:e_commerce/features/customer/settings/widget/change_password_dialog.dart';
import 'package:e_commerce/features/customer/settings/widget/settings_section_card.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:e_commerce/presentation/widgets/buttons/button_type.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsViewModel = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: "Configuración"),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            ...settingsViewModel.sections.map((section) {
              return SettingsSectionCard(
                section: section,
                onAction: (action) => _handleAction(context, action),
              );
            }),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Eliminar cuenta",
                onPressed: () {},
                buttonType: ButtonType.filledButton,
                textColor: Theme.of(context).colorScheme.onError,
                color: Theme.of(context).colorScheme.error,
                icon: Icons.delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _handleAction(BuildContext context, SettingsAction action) {
  switch (action) {
    case SettingsAction.changePassword:
      showDialog(
        context: context,
        builder: (context) => ChangeNotifierProvider(
          create: (_) => ChangePasswordViewModel(),
          child: const ChangePasswordDialog(),
        ),
      );
      break;
    case SettingsAction.biometrics:
      break;
    case SettingsAction.savedCards:
      context.push('/payments');
      break;
    case SettingsAction.addresses:
      context.push('/addresses');
      break;
    case SettingsAction.logout:
      break;
    case SettingsAction.none:
      break;
  }
}
