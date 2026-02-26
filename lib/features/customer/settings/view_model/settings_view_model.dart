import 'package:e_commerce/features/customer/settings/domain/settings_enums.dart';
import 'package:e_commerce/features/customer/settings/model/action_item.dart';
import 'package:e_commerce/features/customer/settings/model/settings_section_model.dart';
import 'package:e_commerce/features/customer/settings/model/switch_item.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  bool _biometricsEnabled = false;
  bool _faceIdEnabled = false;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = false;

  List<SettingsSectionModel> get sections => [
    SettingsSectionModel(
      title: "Seguridad",
      children: [
        ActionItem(
          title: "Cambiar contraseña",
          icon: Icons.lock,
          action: SettingsAction.changePassword,
        ),
        ActionItem(
          title: "Tarjetas guardadas",
          icon: Icons.credit_card,
          action: SettingsAction.savedCards,
        ),
        const ActionItem(
          title: "Direcciones guardadas",
          subTitle: "5ta Avenida 123, CDMX",
          icon: Icons.location_on,
          action: SettingsAction.addresses,
        ),

        SwitchItem(
          title: "Huella digital",
          icon: Icons.fingerprint,
          value: _biometricsEnabled,
          onChanged: (val) {
            _biometricsEnabled = val;
            notifyListeners();
          },
        ),
        SwitchItem(
          title: "Reconocimiento facial",
          icon: Icons.face,
          value: _faceIdEnabled,
          onChanged: (val) {
            _faceIdEnabled = val;
            notifyListeners();
          },
        ),
        ActionItem(
          title: "Autenticación de dos factores",
          icon: Icons.security,
          action: SettingsAction.none,
        ),
      ],
    ),
    SettingsSectionModel(
      title: "Notificaciones",
      children: [
        SwitchItem(
          title: "Notificaciones push",
          icon: Icons.notifications,
          value: _pushNotifications,
          onChanged: (val) {
            _pushNotifications = val;
            notifyListeners();
          },
        ),
        SwitchItem(
          title: "Correo electrónico",
          icon: Icons.email,
          value: _emailNotifications,
          onChanged: (val) {
            _emailNotifications = val;
            notifyListeners();
          },
        ),
        SwitchItem(
          title: "SMS",
          icon: Icons.sms,
          value: _smsNotifications,
          onChanged: (val) {
            _smsNotifications = val;
            notifyListeners();
          },
        ),
      ],
    ),
    SettingsSectionModel(
      title: "Privacidad",
      children: [
        ActionItem(
          title: "Datos personales",
          icon: Icons.person,
          onTap: (_) {},
        ),
        ActionItem(title: "Ubicación", icon: Icons.location_on, onTap: (_) {}),
        ActionItem(
          title: "Contenido personalizado",
          icon: Icons.star,
          onTap: (context) {},
        ),
      ],
    ),
    SettingsSectionModel(
      title: "General",
      children: [
        ActionItem(title: "Idioma", icon: Icons.language, onTap: (_) {}),
        ActionItem(title: "Tema", icon: Icons.palette, onTap: (_) {}),
        ActionItem(title: "Acerca de", icon: Icons.info, onTap: (_) {}),
      ],
    ),
  ];
}
