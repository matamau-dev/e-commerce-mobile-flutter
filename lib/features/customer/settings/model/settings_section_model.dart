import 'package:e_commerce/features/customer/settings/model/settings_item.dart';

class SettingsSectionModel {
  final String title;
  final List<SettingsItem> children;

  SettingsSectionModel({required this.title, required this.children});
}
