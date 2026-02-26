import 'package:flutter/material.dart';
import 'package:e_commerce/features/customer/settings/model/settings_item.dart';

class SwitchItem extends SettingsItem {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchItem({
    required super.title,
    required super.icon,
    required this.value,
    required this.onChanged,
  });
}
