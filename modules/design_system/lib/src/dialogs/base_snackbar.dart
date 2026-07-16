import 'package:design_system/src/tokens/design_tokens.dart';
import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:flutter/material.dart';

class BaseSnackbar {
  BaseSnackbar._();

  static void show(
    BuildContext context, {
    required String message,
    BaseSnackbarType type = BaseSnackbarType.info,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    Widget? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? accentColor,
  }) {
    final colors = _resolveColors(context, type);
    final resolvedBg = backgroundColor ?? colors.background;
    final resolvedFg = foregroundColor ?? colors.foreground;
    final resolvedAccent = accentColor ?? colors.accent;
    final resolvedIcon =
        icon ?? Icon(colors.iconData, color: resolvedAccent, size: 20);

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          duration: duration,
          behavior: behavior,
          backgroundColor: resolvedBg,
          margin: behavior == SnackBarBehavior.floating
              ? EdgeInsets.all(DesignTokens.spacing.md)
              : null,
          shape: behavior == SnackBarBehavior.floating
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(DesignTokens.radius.md),
                  ),
                )
              : null,
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing.md,
            vertical: 14,
          ),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              resolvedIcon,
              SizedBox(width: DesignTokens.spacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: context.designTextTheme.bodyMedium?.copyWith(
                    color: resolvedFg,
                  ),
                ),
              ),
            ],
          ),
          action: actionLabel != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: resolvedAccent,
                  onPressed: onAction ?? () {},
                )
              : null,
        ),
      );
  }

  static void success(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) => show(
    context,
    message: message,
    type: BaseSnackbarType.success,
    actionLabel: actionLabel,
    onAction: onAction,
    duration: duration,
  );

  static void error(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) => show(
    context,
    message: message,
    type: BaseSnackbarType.error,
    actionLabel: actionLabel,
    onAction: onAction,
    duration: duration,
  );

  static void warning(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) => show(
    context,
    message: message,
    type: BaseSnackbarType.warning,
    actionLabel: actionLabel,
    onAction: onAction,
    duration: duration,
  );

  static void info(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) => show(
    context,
    message: message,
    type: BaseSnackbarType.info,
    actionLabel: actionLabel,
    onAction: onAction,
    duration: duration,
  );

  static void hide(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

  static _SnackbarColors _resolveColors(
    BuildContext context,
    BaseSnackbarType type,
  ) {
    final cs = context.designColors;
    final semanticColors = context.designSemanticColors;

    return switch (type) {
      BaseSnackbarType.success => _SnackbarColors(
        background: cs.surface,
        foreground: cs.onSurface,
        accent: semanticColors.success,
        iconData: Icons.check_circle_outline_rounded,
      ),
      BaseSnackbarType.warning => _SnackbarColors(
        background: cs.surface,
        foreground: cs.onSurface,
        accent: semanticColors.warning,
        iconData: Icons.warning_amber_rounded,
      ),
      BaseSnackbarType.info => _SnackbarColors(
        background: cs.surface,
        foreground: cs.onSurface,
        accent: semanticColors.info,
        iconData: Icons.info_outline_rounded,
      ),
      BaseSnackbarType.error => _SnackbarColors(
        background: cs.surface,
        foreground: cs.onSurface,
        accent: semanticColors.destructive,
        iconData: Icons.error_outline_rounded,
      ),
    };
  }
}

class _SnackbarColors {
  const _SnackbarColors({
    required this.background,
    required this.foreground,
    required this.accent,
    required this.iconData,
  });

  final Color background;
  final Color foreground;
  final Color accent;
  final IconData iconData;
}

enum BaseSnackbarType { success, error, info, warning }
