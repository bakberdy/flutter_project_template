import 'package:design_system/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

import '../tokens/design_component_sizes.dart';
import '../tokens/design_elevation.dart';
import '../tokens/design_motion.dart';
import '../tokens/design_radii.dart';
import '../tokens/design_spacing.dart';
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
      borderRadius: BorderRadius.circular(DesignRadii.md),
    );
    final surfaceShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DesignRadii.lg),
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
        elevation: DesignElevation.none,
        scrolledUnderElevation: DesignElevation.xs,
        centerTitle: false,
        toolbarHeight: DesignComponentSizes.appBar,
        titleTextStyle: textTheme.titleLarge?.copyWith(color: colors.onSurface),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        elevation: DesignElevation.none,
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
        elevation: DesignElevation.lg,
        modalElevation: DesignElevation.lg,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(DesignRadii.sheet),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        showDragHandle: false,
      ),
      cardTheme: CardThemeData(
        color: colors.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shadowColor: colors.shadow,
        elevation: DesignElevation.xs,
        margin: EdgeInsets.zero,
        shape: surfaceShape,
        clipBehavior: Clip.antiAlias,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignRadii.xs),
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
        padding: const EdgeInsets.symmetric(horizontal: DesignSpacing.xs),
        labelPadding: const EdgeInsets.symmetric(horizontal: DesignSpacing.xs),
        brightness: colors.brightness,
        elevation: DesignElevation.none,
        pressElevation: DesignElevation.xs,
        showCheckmark: true,
      ),
      dataTableTheme: DataTableThemeData(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.outlineVariant),
          borderRadius: BorderRadius.circular(DesignRadii.lg),
        ),
        headingRowColor: WidgetStatePropertyAll(colors.surfaceContainerLow),
        dataRowColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colors.primaryContainer.withValues(alpha: 0.45)
              : colors.surface,
        ),
        headingTextStyle: textTheme.titleSmall,
        dataTextStyle: textTheme.bodyMedium,
        headingRowHeight: DesignComponentSizes.controlLg,
        dataRowMinHeight: DesignComponentSizes.controlLg,
        dataRowMaxHeight: DesignComponentSizes.bottomNavigation,
        horizontalMargin: DesignSpacing.md,
        columnSpacing: DesignSpacing.lg,
        dividerThickness: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shadowColor: colors.shadow,
        elevation: DesignElevation.xl,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignRadii.xxl),
        ),
        iconColor: colors.onSurfaceVariant,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: colors.onSurface,
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          DesignSpacing.lg,
          0,
          DesignSpacing.lg,
          DesignSpacing.lg,
        ),
        insetPadding: const EdgeInsets.all(DesignSpacing.lg),
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
            Size(64, DesignComponentSizes.controlLg),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: DesignSpacing.lg),
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
            Size.square(DesignComponentSizes.minimumTouchTarget),
          ),
          iconSize: const WidgetStatePropertyAll(DesignComponentSizes.iconMd),
          foregroundColor: _defaultForeground(colors, semanticColors),
          shape: const WidgetStatePropertyAll(CircleBorder()),
        ),
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
        errorStyle: TextStyle(color: colors.error),
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
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignRadii.md),
          borderSide: BorderSide(color: semanticColors.disabled),
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
      listTileTheme: ListTileThemeData(
        iconColor: colors.onSurfaceVariant,
        textColor: colors.onSurface,
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignSpacing.md,
          vertical: DesignSpacing.xs,
        ),
        shape: controlShape,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: DesignComponentSizes.bottomNavigation,
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: DesignElevation.none,
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
        elevation: DesignElevation.none,
        minWidth: DesignComponentSizes.navigationRail,
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
            Size(64, DesignComponentSizes.controlLg),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: DesignSpacing.lg),
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
        elevation: DesignElevation.lg,
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
        elevation: DesignElevation.lg,
        shape: controlShape,
        insetPadding: const EdgeInsets.all(DesignSpacing.md),
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
            Size(48, DesignComponentSizes.controlLg),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: DesignSpacing.md),
          ),
          shape: WidgetStatePropertyAll(controlShape),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          foregroundColor: _defaultForeground(colors, semanticColors),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colors.inverseSurface,
          borderRadius: BorderRadius.circular(DesignRadii.sm),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: colors.onInverseSurface,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: DesignSpacing.sm,
          vertical: DesignSpacing.xs,
        ),
        waitDuration: DesignMotionDurations.slow,
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
