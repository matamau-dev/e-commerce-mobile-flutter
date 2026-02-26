import 'package:e_commerce/features/customer/settings/domain/settings_enums.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/features/customer/settings/model/settings_item.dart';

class ActionItem extends SettingsItem {
  final String? subTitle;
  final void Function(BuildContext)? onTap;
  final SettingsAction action;

  const ActionItem({
    required super.title,
    required super.icon,
    this.subTitle,
    this.onTap,
    this.action = SettingsAction.none,
  });
}
