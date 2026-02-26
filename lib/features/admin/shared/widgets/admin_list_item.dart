import 'package:flutter/material.dart';

class AdminListItem extends StatelessWidget {
  final List<String> items;
  final Function(String name) onEdit;
  final Function(String name) onDelete;
  final IconData icon;

  const AdminListItem({
    super.key,
    required this.items,
    required this.onEdit,
    required this.onDelete,
    this.icon = Icons.category,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(thickness: .5),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Text(
                items[index],
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => onEdit(items[index]),
                icon: Icon(
                  Icons.edit,
                  size: 24,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              IconButton(
                onPressed: () => onDelete(items[index]),
                icon: Icon(
                  Icons.delete,
                  size: 24,
                  color: Theme.of(
                    context,
                  ).colorScheme.error.withValues(alpha: .7),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
