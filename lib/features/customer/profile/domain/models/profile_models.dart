import 'package:flutter/material.dart';

class MenuOption {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? route;
  final Map<String, dynamic>? arguments;
  final String? id; // For special actions like "logout" or "suggestions"

  MenuOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.route,
    this.arguments,
    this.id,
  });
}

class ProfileSection {
  final String title;
  final String? actionLabel;
  final String? actionId;
  final List<MenuOption> options;

  ProfileSection({
    required this.title,
    this.actionLabel,
    this.actionId,
    required this.options,
  });
}
