import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('configures divider theme from the active color scheme', () {
    for (final theme in [DesignTheme.light(), DesignTheme.dark()]) {
      expect(theme.dividerTheme.color, theme.colorScheme.outlineVariant);
      expect(theme.dividerTheme.space, 1);
      expect(theme.dividerTheme.thickness, 1);
    }
  });

  test('configures input decoration theme from the active color scheme', () {
    for (final theme in [DesignTheme.light(), DesignTheme.dark()]) {
      final inputTheme = theme.inputDecorationTheme;

      expect(inputTheme.filled, isTrue);
      expect(inputTheme.fillColor, theme.colorScheme.surface);
      expect(
        (inputTheme.enabledBorder! as OutlineInputBorder).borderSide.color,
        theme.colorScheme.outlineVariant,
      );
      expect(
        (inputTheme.focusedBorder! as OutlineInputBorder).borderSide.color,
        theme.colorScheme.primary,
      );
      expect(
        (inputTheme.errorBorder! as OutlineInputBorder).borderSide.color,
        theme.colorScheme.error,
      );
    }
  });
}
