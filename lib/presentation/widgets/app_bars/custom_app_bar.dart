import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Widget? leading;
  final List<Widget>? actions;
  final double? elevation;
  final VoidCallback? onLeadingPressed;

  final bool showSearchBar;
  final ValueChanged<String>? onSearchChanged;

  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.elevation = 0,
    this.onLeadingPressed,
    this.showSearchBar = false,
    this.onSearchChanged,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: showSearchBar
          ? _buildSearchBar(context)
          : Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

      centerTitle: centerTitle,
      elevation: elevation,
      scrolledUnderElevation: 0,

      leading:
          leading ??
          (Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  onPressed:
                      onLeadingPressed ?? () => Navigator.of(context).pop(),
                )
              : null),

      actions: actions,
      bottom: bottom,
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: title,
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        fillColor: Colors.grey[200],
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
