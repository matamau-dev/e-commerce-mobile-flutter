import 'package:e_commerce/features/customer/profile/domain/models/profile_models.dart';
import 'package:flutter/material.dart';

class ProfileOptionItem extends StatelessWidget {
  final MenuOption option;
  final VoidCallback onTap;

  const ProfileOptionItem({
    super.key,
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          option.icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        option.title,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: option.subtitle.isNotEmpty
          ? Text(option.subtitle, style: Theme.of(context).textTheme.bodySmall)
          : null,
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      contentPadding: EdgeInsets.zero,
    );
  }
}
