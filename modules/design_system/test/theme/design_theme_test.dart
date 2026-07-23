import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final themes = [DesignTheme.light(), DesignTheme.dark()];

  test('uses the Montserrat family across the text theme', () {
    for (final theme in themes) {
      expect(theme.textTheme.bodyMedium?.fontFamily, FontFamily.montserrat);
      expect(theme.textTheme.headlineMedium?.fontFamily, FontFamily.montserrat);
      expect(theme.textTheme.labelLarge?.fontWeight, FontWeight.w600);
    }
  });

  test('registers the matching semantic palette', () {
    expect(
      DesignTheme.light().extension<DesignSemanticColors>(),
      DesignSemanticColors.light,
    );
    expect(
      DesignTheme.dark().extension<DesignSemanticColors>(),
      DesignSemanticColors.dark,
    );
  });

  test('configures divider theme from the active color scheme', () {
    for (final theme in themes) {
      expect(theme.dividerTheme.color, theme.colorScheme.outlineVariant);
      expect(theme.dividerTheme.space, 1);
      expect(theme.dividerTheme.thickness, 1);
    }
  });

  test('configures input decoration theme from the active color scheme', () {
    for (final theme in themes) {
      final inputTheme = theme.inputDecorationTheme;
      final enabledBorder = switch (inputTheme.enabledBorder) {
        final OutlineInputBorder border => border,
        _ => throw StateError('Expected an enabled outline border'),
      };
      final focusedBorder = switch (inputTheme.focusedBorder) {
        final OutlineInputBorder border => border,
        _ => throw StateError('Expected a focused outline border'),
      };
      final errorBorder = switch (inputTheme.errorBorder) {
        final OutlineInputBorder border => border,
        _ => throw StateError('Expected an error outline border'),
      };

      expect(inputTheme.filled, isTrue);
      expect(inputTheme.fillColor, theme.colorScheme.surface);
      expect(
        enabledBorder.borderSide.color,
        theme.colorScheme.outlineVariant,
      );
      expect(
        focusedBorder.borderSide.color,
        theme.colorScheme.primary,
      );
      expect(
        errorBorder.borderSide.color,
        theme.colorScheme.error,
      );
    }
  });

  test('configures surface component themes', () {
    for (final theme in themes) {
      expect(theme.appBarTheme.backgroundColor, theme.colorScheme.surface);
      expect(theme.cardTheme.color, theme.colorScheme.surfaceContainerLow);
      expect(
        theme.dialogTheme.backgroundColor,
        theme.colorScheme.surfaceContainerHigh,
      );
      expect(theme.bottomSheetTheme.backgroundColor, theme.colorScheme.surface);
      expect(
        theme.navigationRailTheme.indicatorColor,
        theme.colorScheme.primaryContainer,
      );
      expect(
        theme.dataTableTheme.headingRowColor?.resolve({}),
        theme.colorScheme.surfaceContainerLow,
      );
    }
  });

  test('configures interactive component state colors', () {
    for (final theme in themes) {
      final semanticColors = switch (theme.extension<DesignSemanticColors>()) {
        final DesignSemanticColors colors => colors,
        _ => throw StateError('Expected semantic colors'),
      };
      final disabled = {WidgetState.disabled};
      final selected = {WidgetState.selected};

      expect(
        theme.filledButtonTheme.style?.backgroundColor?.resolve(disabled),
        semanticColors.disabled,
      );
      expect(
        theme.outlinedButtonTheme.style?.foregroundColor?.resolve(disabled),
        semanticColors.onDisabled,
      );
      expect(
        theme.switchTheme.trackColor?.resolve(selected),
        theme.colorScheme.primary,
      );
      expect(
        theme.radioTheme.fillColor?.resolve(selected),
        theme.colorScheme.primary,
      );
      expect(theme.colorScheme.error, semanticColors.destructive);
    }
  });
}
