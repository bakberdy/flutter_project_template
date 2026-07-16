import 'package:design_system/src/tokens/design_tokens.dart';
import 'package:design_system/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

import 'design_semantic_colors.dart';
import 'design_typography.dart';

class DesignTheme {
  const DesignTheme._();

  static const _seedColor = Color(0xFF2563EB);

  static ThemeData light() {
    const semanticColors = DesignSemanticColors.light;
    return _build(
      _colorScheme(Brightness.light, semanticColors),
      semanticColors,
    );
  }

  static ThemeData dark() {
    const semanticColors = DesignSemanticColors.dark;
    return _build(
      _colorScheme(Brightness.dark, semanticColors),
      semanticColors,
    );
  }

  static ColorScheme _colorScheme(
    Brightness brightness,
    DesignSemanticColors semanticColors,
  ) => ColorScheme.fromSeed(seedColor: _seedColor, brightness: brightness)
      .copyWith(
        error: semanticColors.destructive,
        onError: semanticColors.onDestructive,
        errorContainer: semanticColors.destructiveContainer,
        onErrorContainer: semanticColors.onDestructiveContainer,
      );

  static ThemeData _build(
    ColorScheme colors,
    DesignSemanticColors semanticColors,
  ) {
    final textTheme = DesignTypography.textTheme(colors);
    final controlShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DesignRadiusTokens.md),
    );
    final surfaceShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DesignRadiusTokens.lg),
    );

    return ThemeData(
      brightness: colors.brightness,
      colorScheme: colors,
      extensions: [semanticColors],
      fontFamily: FontFamily.montserrat,
      scaffoldBackgroundColor: colors.surface,
      textTheme: textTheme,
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarThemeData(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: DesignElevationTokens.none,
        scrolledUnderElevation: DesignElevationTokens.xs,
        centerTitle: false,
        toolbarHeight: DesignSizeTokens.appBar,
        titleTextStyle: textTheme.titleLarge?.copyWith(color: colors.onSurface),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        elevation: DesignElevationTokens.none,
        enableFeedback: false,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(color: colors.primary),
        unselectedIconTheme: IconThemeData(color: colors.onSurfaceVariant),
        selectedLabelStyle: textTheme.labelMedium?.copyWith(
          color: colors.primary,
        ),
        unselectedLabelStyle: textTheme.labelMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        modalBackgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: DesignElevationTokens.lg,
        modalElevation: DesignElevationTokens.lg,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(DesignRadiusTokens.sheet),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        showDragHandle: false,
      ),
      cardTheme: CardThemeData(
        color: colors.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shadowColor: colors.shadow,
        elevation: DesignElevationTokens.xs,
        margin: EdgeInsets.zero,
        shape: surfaceShape,
        clipBehavior: Clip.antiAlias,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignRadiusTokens.xs),
        ),
        fillColor: _selectionFillColor(colors, semanticColors),
        side: BorderSide(color: colors.outline),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceContainerLow,
        disabledColor: semanticColors.disabled,
        selectedColor: colors.primaryContainer,
        secondarySelectedColor: colors.secondaryContainer,
        checkmarkColor: colors.onPrimaryContainer,
        deleteIconColor: colors.onSurfaceVariant,
        side: BorderSide(color: colors.outlineVariant),
        shape: const StadiumBorder(),
        labelStyle: textTheme.labelLarge?.copyWith(color: colors.onSurface),
        secondaryLabelStyle: textTheme.labelLarge?.copyWith(
          color: colors.onSecondaryContainer,
        ),
        padding: const EdgeInsets.symmetric(horizontal: DesignSpacingTokens.xs),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: DesignSpacingTokens.xs,
        ),
        brightness: colors.brightness,
        elevation: DesignElevationTokens.none,
        pressElevation: DesignElevationTokens.xs,
        showCheckmark: true,
      ),
      dataTableTheme: DataTableThemeData(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.outlineVariant),
          borderRadius: BorderRadius.circular(DesignRadiusTokens.lg),
        ),
        headingRowColor: WidgetStatePropertyAll(colors.surfaceContainerLow),
        dataRowColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colors.primaryContainer.withValues(alpha: 0.45)
              : colors.surface,
        ),
        headingTextStyle: textTheme.titleSmall,
        dataTextStyle: textTheme.bodyMedium,
        headingRowHeight: DesignSizeTokens.controlLg,
        dataRowMinHeight: DesignSizeTokens.controlLg,
        dataRowMaxHeight: DesignSizeTokens.bottomNavigation,
        horizontalMargin: DesignSpacingTokens.md,
        columnSpacing: DesignSpacingTokens.lg,
        dividerThickness: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shadowColor: colors.shadow,
        elevation: DesignElevationTokens.xl,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignRadiusTokens.xxl),
        ),
        iconColor: colors.onSurfaceVariant,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: colors.onSurface,
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          DesignSpacingTokens.lg,
          0,
          DesignSpacingTokens.lg,
          DesignSpacingTokens.lg,
        ),
        insetPadding: const EdgeInsets.all(DesignSpacingTokens.lg),
        clipBehavior: Clip.antiAlias,
      ),
      dividerTheme: DividerThemeData(
        color: colors.outlineVariant,
        space: 1,
        thickness: 1,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(64, DesignSizeTokens.controlLg),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: DesignSpacingTokens.lg),
          ),
          shape: WidgetStatePropertyAll(controlShape),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          backgroundColor: _filledButtonBackground(colors, semanticColors),
          foregroundColor: _filledButtonForeground(colors, semanticColors),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size.square(DesignSizeTokens.minimumTouchTarget),
          ),
          iconSize: const WidgetStatePropertyAll(DesignSizeTokens.iconMd),
          foregroundColor: _defaultForeground(colors, semanticColors),
          shape: const WidgetStatePropertyAll(CircleBorder()),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignSpacingTokens.md,
          vertical: DesignSpacingTokens.sm,
        ),
        labelStyle: TextStyle(color: colors.onSurfaceVariant),
        hintStyle: TextStyle(color: colors.onSurfaceVariant),
        errorStyle: TextStyle(color: colors.error),
        prefixIconColor: colors.onSurfaceVariant,
        suffixIconColor: colors.onSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignRadiusTokens.md),
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignRadiusTokens.md),
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignRadiusTokens.md),
          borderSide: BorderSide(color: semanticColors.disabled),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignRadiusTokens.md),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignRadiusTokens.md),
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignRadiusTokens.md),
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colors.onSurfaceVariant,
        textColor: colors.onSurface,
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignSpacingTokens.md,
          vertical: DesignSpacingTokens.xs,
        ),
        shape: controlShape,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: DesignSizeTokens.bottomNavigation,
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: DesignElevationTokens.none,
        indicatorColor: colors.primaryContainer,
        indicatorShape: const StadiumBorder(),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? colors.onPrimaryContainer
                : colors.onSurfaceVariant,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? colors.primary
                : colors.onSurfaceVariant,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colors.surface,
        elevation: DesignElevationTokens.none,
        minWidth: DesignSizeTokens.navigationRail,
        minExtendedWidth: 240,
        useIndicator: true,
        indicatorColor: colors.primaryContainer,
        indicatorShape: const StadiumBorder(),
        selectedIconTheme: IconThemeData(color: colors.onPrimaryContainer),
        unselectedIconTheme: IconThemeData(color: colors.onSurfaceVariant),
        selectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: colors.primary,
        ),
        unselectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(64, DesignSizeTokens.controlLg),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: DesignSpacingTokens.lg),
          ),
          shape: WidgetStatePropertyAll(controlShape),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          foregroundColor: _defaultForeground(colors, semanticColors),
          side: _outlinedButtonSide(colors, semanticColors),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: colors.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        elevation: DesignElevationTokens.lg,
        shape: surfaceShape,
        textStyle: textTheme.bodyMedium,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
        linearTrackColor: colors.surfaceContainerHighest,
        circularTrackColor: colors.surfaceContainerHighest,
      ),
      radioTheme: RadioThemeData(
        fillColor: _selectionFillColor(colors, semanticColors),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colors.onInverseSurface,
        ),
        actionTextColor: colors.inversePrimary,
        disabledActionTextColor: semanticColors.onDisabled,
        elevation: DesignElevationTokens.lg,
        shape: controlShape,
        insetPadding: const EdgeInsets.all(DesignSpacingTokens.md),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return semanticColors.onDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return colors.onPrimary;
          }
          return colors.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return semanticColors.disabled;
          }
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return colors.surfaceContainerHighest;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return semanticColors.disabled;
          }
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return colors.outline;
        }),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(48, DesignSizeTokens.controlLg),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: DesignSpacingTokens.md),
          ),
          shape: WidgetStatePropertyAll(controlShape),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          foregroundColor: _defaultForeground(colors, semanticColors),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colors.inverseSurface,
          borderRadius: BorderRadius.circular(DesignRadiusTokens.sm),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: colors.onInverseSurface,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: DesignSpacingTokens.sm,
          vertical: DesignSpacingTokens.xs,
        ),
        waitDuration: DesignDurationTokens.slow,
      ),
    );
  }

  static WidgetStateProperty<Color?> _filledButtonBackground(
    ColorScheme colors,
    DesignSemanticColors semanticColors,
  ) => WidgetStateProperty.resolveWith(
    (states) => states.contains(WidgetState.disabled)
        ? semanticColors.disabled
        : colors.primary,
  );

  static WidgetStateProperty<Color?> _filledButtonForeground(
    ColorScheme colors,
    DesignSemanticColors semanticColors,
  ) => WidgetStateProperty.resolveWith(
    (states) => states.contains(WidgetState.disabled)
        ? semanticColors.onDisabled
        : colors.onPrimary,
  );

  static WidgetStateProperty<Color?> _defaultForeground(
    ColorScheme colors,
    DesignSemanticColors semanticColors,
  ) => WidgetStateProperty.resolveWith(
    (states) => states.contains(WidgetState.disabled)
        ? semanticColors.onDisabled
        : colors.primary,
  );

  static WidgetStateProperty<BorderSide?> _outlinedButtonSide(
    ColorScheme colors,
    DesignSemanticColors semanticColors,
  ) => WidgetStateProperty.resolveWith(
    (states) => BorderSide(
      color: states.contains(WidgetState.disabled)
          ? semanticColors.disabled
          : colors.outline,
    ),
  );

  static WidgetStateProperty<Color?> _selectionFillColor(
    ColorScheme colors,
    DesignSemanticColors semanticColors,
  ) => WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return semanticColors.disabled;
    }
    if (states.contains(WidgetState.selected)) {
      return colors.primary;
    }
    return Colors.transparent;
  });
}
