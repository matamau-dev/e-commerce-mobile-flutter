import 'package:e_commerce/features/customer/settings/model/action_item.dart';
import 'package:e_commerce/features/customer/settings/model/settings_item.dart';
import 'package:e_commerce/features/customer/settings/model/switch_item.dart';
import 'package:flutter/material.dart';

class SettingsOptionTile extends StatelessWidget {
  const SettingsOptionTile({
    super.key,
    required this.item,
    required this.onTapModal,
  });

  final SettingsItem item;
  final VoidCallback? onTapModal;

  @override
  Widget build(BuildContext context) {
    String? subtitle;
    Widget? trailing;
    VoidCallback? tileOnTap;

    if (item is ActionItem) {
      final actionItem = item as ActionItem;
      subtitle = actionItem.subTitle;

      trailing = Icon(
        Icons.chevron_right,
        size: 20,
        color: Colors.grey.shade400,
      );

      tileOnTap = onTapModal;
    } else if (item is SwitchItem) {
      final switchItem = item as SwitchItem;

      trailing = Switch(
        value: switchItem.value,
        onChanged: switchItem.onChanged,
        activeColor: Theme.of(context).colorScheme.primary,
      );

      tileOnTap = () => switchItem.onChanged(!switchItem.value);
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          item.icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            )
          : null,
      trailing: trailing,
      onTap: tileOnTap,
    );
  }
}
