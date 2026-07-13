import 'package:design_system/src/buttons/base_button_progress.dart';
import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:design_system/src/tokens/design_radii.dart';
import 'package:design_system/src/tokens/design_spacing.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton._({
    super.key,
    required this._variant,
    required this.onPressed,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    required this.expand,
    this.borderRadius,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.disabled = false,
    this.loading = false,
  });

  factory BaseButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool expand = false,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disabled = false,
    bool loading = false,
  }) => BaseButton._(
    key: key,
    variant: _BaseButtonVariant.primary,
    onPressed: onPressed,
    label: label,
    leadingIcon: leadingIcon,
    trailingIcon: trailingIcon,
    expand: expand,
    borderRadius: borderRadius,
    padding: padding,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    disabled: disabled,
    loading: loading,
  );

  factory BaseButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool expand = false,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    bool disabled = false,
    bool loading = false,
  }) => BaseButton._(
    key: key,
    variant: _BaseButtonVariant.secondary,
    onPressed: onPressed,
    label: label,
    leadingIcon: leadingIcon,
    trailingIcon: trailingIcon,
    expand: expand,
    borderRadius: borderRadius,
    padding: padding,
    disabled: disabled,
    loading: loading,
  );

  factory BaseButton.destructive({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool expand = false,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    bool disabled = false,
    bool loading = false,
  }) => BaseButton._(
    key: key,
    variant: _BaseButtonVariant.destructive,
    onPressed: onPressed,
    label: label,
    leadingIcon: leadingIcon,
    trailingIcon: trailingIcon,
    expand: expand,
    borderRadius: borderRadius,
    padding: padding,
    disabled: disabled,
    loading: loading,
  );

  final _BaseButtonVariant _variant;
  final VoidCallback? onPressed;
  final String label;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool expand;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool disabled;
  final bool loading;

  VoidCallback? get _effectiveOnPressed =>
      (loading || disabled) ? null : onPressed;

  Color _progressColor(BuildContext context) {
    final s = context.designColors;
    final foregroundColor = this.foregroundColor;
    return switch (_variant) {
      _BaseButtonVariant.primary => foregroundColor ?? s.onPrimary,
      _BaseButtonVariant.secondary => s.primary,
      _BaseButtonVariant.destructive => s.error,
    };
  }

  @override
  Widget build(BuildContext context) {
    final progress = baseButtonProgressIndicator(_progressColor(context));
    final child = _ButtonContent(
      label: label,
      leading: loading ? progress : leadingIcon,
      trailing: loading ? null : trailingIcon,
    );

    final Widget button = switch (_variant) {
      _BaseButtonVariant.primary => FilledButton(
        onPressed: _effectiveOnPressed,
        style: _primaryStyle(context),
        child: child,
      ),
      _BaseButtonVariant.secondary => OutlinedButton(
        onPressed: _effectiveOnPressed,
        style: _secondaryStyle(),
        child: child,
      ),
      _BaseButtonVariant.destructive => OutlinedButton(
        onPressed: _effectiveOnPressed,
        style: _destructiveStyle(context),
        child: child,
      ),
    };

    if (expand) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  ButtonStyle? _primaryStyle(BuildContext context) {
    final shape = WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(DesignRadii.md),
      ),
    );

    if (borderRadius != null ||
        padding != null ||
        backgroundColor != null ||
        foregroundColor != null) {
      return ButtonStyle(
        backgroundColor: _backgroundColor(context),
        foregroundColor: _foregroundColor(context),
        padding: _padding(),
        shape: shape,
      );
    }

    return null;
  }

  ButtonStyle? _secondaryStyle() {
    if (borderRadius == null && padding == null) {
      return null;
    }

    return ButtonStyle(
      padding: _padding(),
      shape: borderRadius == null
          ? null
          : WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: borderRadius!),
            ),
    );
  }

  ButtonStyle _destructiveStyle(BuildContext context) {
    final s = context.designColors;
    return ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return s.onSurface.withValues(alpha: 0.38);
        }
        return s.error;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(color: s.onSurface.withValues(alpha: 0.12));
        }
        return BorderSide(color: s.error);
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return s.error.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return s.error.withValues(alpha: 0.08);
        }
        return null;
      }),
      padding: _padding(),
      shape: borderRadius == null
          ? null
          : WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: borderRadius!),
            ),
    );
  }

  WidgetStateProperty<Color?>? _backgroundColor(BuildContext context) {
    final backgroundColor = this.backgroundColor;
    if (backgroundColor == null) {
      return null;
    }
    final s = context.designColors;
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return s.onSurface.withValues(alpha: 0.12);
      }
      return backgroundColor;
    });
  }

  WidgetStateProperty<Color?>? _foregroundColor(BuildContext context) {
    final foregroundColor = this.foregroundColor;
    if (foregroundColor == null) {
      return null;
    }
    final s = context.designColors;
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return s.onSurface.withValues(alpha: 0.38);
      }
      return foregroundColor;
    });
  }

  WidgetStateProperty<EdgeInsetsGeometry?>? _padding() {
    final padding = this.padding;
    if (padding == null) {
      return null;
    }
    return WidgetStateProperty.all(padding);
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.leading,
    required this.trailing,
  });

  final String label;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: DesignSpacing.xs),
        ],
        Text(label),
        if (trailing != null) ...[
          const SizedBox(width: DesignSpacing.xs),
          trailing!,
        ],
      ],
    );
  }
}

enum _BaseButtonVariant { primary, secondary, destructive }
