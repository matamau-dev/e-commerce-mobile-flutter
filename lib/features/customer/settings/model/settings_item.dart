import 'package:flutter/material.dart';

abstract class SettingsItem {
  final String title;
  final IconData icon;

  const SettingsItem({required this.title, required this.icon});
}
