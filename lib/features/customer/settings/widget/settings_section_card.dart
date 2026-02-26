import 'package:e_commerce/features/customer/settings/domain/settings_enums.dart';
import 'package:e_commerce/features/customer/settings/model/action_item.dart';
import 'package:e_commerce/features/customer/settings/model/settings_section_model.dart';
import 'package:flutter/material.dart';
import 'settings_option_tile.dart';

class SettingsSectionCard extends StatelessWidget {
  const SettingsSectionCard({
    super.key,
    required this.section,
    required this.onAction,
  });

  final SettingsSectionModel section;
  final void Function(SettingsAction)? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              section.title.toUpperCase(),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),

          Divider(height: 1, color: Colors.grey.shade100),

          ...section.children.map((option) {
            return Column(
              children: [
                SettingsOptionTile(
                  item: option,
                  onTapModal: () {
                    if (option is ActionItem) {
                      onAction?.call(option.action);
                    }
                  },
                ),
                if (option != section.children.last)
                  Divider(height: 1, indent: 60, color: Colors.grey.shade100),
              ],
            );
          }),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
