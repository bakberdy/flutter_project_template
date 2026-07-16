import 'package:design_system/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

abstract final class DesignTypography {
  static TextTheme textTheme(ColorScheme colors) {
    final typography = Typography.material2021(colorScheme: colors);
    final base = colors.brightness == Brightness.light
        ? typography.black
        : typography.white;

    return base
        .apply(fontFamily: FontFamily.montserrat)
        .copyWith(
          displayLarge: base.displayLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          displayMedium: base.displayMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          displaySmall: base.displaySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: base.headlineLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: base.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: base.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          titleSmall: base.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          labelMedium: base.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          labelSmall: base.labelSmall?.copyWith(fontWeight: FontWeight.w600),
        )
        .apply(fontFamily: FontFamily.montserrat);
  }
}
