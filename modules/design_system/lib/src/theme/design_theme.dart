import 'package:flutter/material.dart';

import '../tokens/design_radii.dart';
import '../tokens/design_spacing.dart';

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
    dividerTheme: DividerThemeData(
      color: colors.outlineVariant,
      space: 1,
      thickness: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.surface,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: DesignSpacing.md,
        vertical: DesignSpacing.sm,
      ),
      labelStyle: TextStyle(color: colors.onSurfaceVariant),
      hintStyle: TextStyle(color: colors.onSurfaceVariant),
      prefixIconColor: colors.onSurfaceVariant,
      suffixIconColor: colors.onSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignRadii.md),
        borderSide: BorderSide(color: colors.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignRadii.md),
        borderSide: BorderSide(color: colors.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignRadii.md),
        borderSide: BorderSide(color: colors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignRadii.md),
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignRadii.md),
        borderSide: BorderSide(color: colors.error, width: 2),
      ),
    ),
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
