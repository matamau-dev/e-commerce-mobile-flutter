import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00695C);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF83DACC);
  static const Color onPrimaryContainer = Color(0xFF00201C);

  static const Color secondary = Color(0xFFFF7043);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFFDBCF);
  static const Color onSecondaryContainer = Color(0xFF3B0D00);

  static const Color tertiary = Color(0xFF455A64);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFCFD8DC);

  static const Color background = Color(0xFFF2F4F5);
  static const Color onBackground = Color(0xFF191C1C);

  static const Color lowStock = Color(0xFFB71C1C);
  static const Color onLowStock = Color(0xFFFFFFFF);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF191C1C);

  static const Color surfaceVariant = Color.fromARGB(255, 222, 223, 223);
  static const Color onSurfaceVariant = Color(0xFF49454F);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color outline = Color(0xFF6F7979);

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: Color(0xFF191C1D),
    error: error,
    onError: onError,
    surface: surface,
    onSurface: onSurface,
    surfaceContainerHighest: surfaceVariant,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    errorContainer: lowStock,
    onErrorContainer: onLowStock,
    background: background,
    onBackground: onBackground,
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF83DACC),
    onPrimary: Color(0xFF003730),
    primaryContainer: Color(0xFF005045),
    onPrimaryContainer: Color(0xFF9FF2E4),

    secondary: Color(0xFFFFDBCC),
    onSecondary: Color(0xFF5D1900),
    secondaryContainer: Color(0xFF82280C),
    onSecondaryContainer: Color(0xFFFFDBCC),

    tertiary: Color(0xFFB0C6D0),
    onTertiary: Color(0xFF15303B),
    tertiaryContainer: Color(0xFF2D4753),
    onTertiaryContainer: Color(0xFFCCE8F4),

    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),

    surface: Color(0xFF191C1C),
    onSurface: Color(0xFFE0E3E3),

    surfaceContainerHighest: Color(0xFF3F4948),
    onSurfaceVariant: Color(0xFFBFC9C9),

    outline: Color(0xFF899393),

    errorContainer: lowStock,
    onErrorContainer: onLowStock,
    background: background,
    onBackground: onBackground,
  );
}
