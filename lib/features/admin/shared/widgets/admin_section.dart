import 'package:e_commerce/features/admin/shared/widgets/admin_list_item.dart';
import 'package:flutter/material.dart';

class AdminSection extends StatelessWidget {
  final List<String> items;
  final String title;
  final Function(String) onEdit;
  final Function(String) onDelete;
  final IconData icon;

  const AdminSection({
    super.key,
    required this.items,
    required this.title,
    required this.onEdit,
    required this.onDelete,
    this.icon = Icons.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
            ),
          ),
          const SizedBox(height: 4),
          AdminListItem(
            items: items,
            onEdit: onEdit,
            onDelete: onDelete,
            icon: icon,
          ),
        ],
      ),
    );
  }
}
