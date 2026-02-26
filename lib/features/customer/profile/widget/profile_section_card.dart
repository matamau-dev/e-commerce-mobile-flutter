import 'package:e_commerce/features/customer/profile/domain/models/profile_models.dart';
import 'package:e_commerce/presentation/widgets/buttons/button_type.dart';
import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'profile_option_item.dart';

class ProfileSectionCard extends StatelessWidget {
  final ProfileSection section;
  final Function(MenuOption) onOptionTap;
  final Function(ProfileSection)? onActionTap;

  const ProfileSectionCard({
    super.key,
    required this.section,
    required this.onOptionTap,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              if (section.actionLabel != null && onActionTap != null)
                CustomButton(
                  text: section.actionLabel!,
                  buttonType: ButtonType.textButton,
                  onPressed: () => onActionTap!(section),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: section.options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ProfileOptionItem(
                          option: option,
                          onTap: () => onOptionTap(option),
                        ),
                      ),
                      if (index < section.options.length - 1)
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Theme.of(
                            context,
                          ).colorScheme.outlineVariant.withOpacity(0.5),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
