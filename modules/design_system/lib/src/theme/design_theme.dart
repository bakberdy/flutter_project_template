import 'package:flutter/material.dart';

class DesignTheme {
  const DesignTheme._();

  static ThemeData light() =>
      _build(ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)));

  static ThemeData dark() => _build(
    ColorScheme.fromSeed(
      seedColor: const Color(0xFF2563EB),
      brightness: Brightness.dark,
    ),
  );

  static ThemeData _build(ColorScheme colors) => ThemeData(
    colorScheme: colors,
    useMaterial3: true,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.surface,
      elevation: 0,
      enableFeedback: false,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(color: colors.primary),
      unselectedIconTheme: IconThemeData(color: colors.onSurfaceVariant),
      selectedLabelStyle: TextStyle(
        color: colors.primary,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(color: colors.onSurfaceVariant),
    ),
  );
}
