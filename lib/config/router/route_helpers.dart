import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteHelpers {
  static Widget withProvider<T extends ChangeNotifier>({
    required T Function(BuildContext) create,
    required Widget child,
  }) {
    return ChangeNotifierProvider(create: create, child: child);
  }

  static Widget withValueProvider<T extends ChangeNotifier>({
    required T value,
    required Widget child,
  }) {
    return ChangeNotifierProvider.value(value: value, child: child);
  }
}
