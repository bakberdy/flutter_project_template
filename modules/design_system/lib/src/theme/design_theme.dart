import 'package:flutter/material.dart';

class DesignTheme {
  const DesignTheme._();

  static ThemeData light() => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
    useMaterial3: true,
  );

  static ThemeData dark() => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2563EB),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
