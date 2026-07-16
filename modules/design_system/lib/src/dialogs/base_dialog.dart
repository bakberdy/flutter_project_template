import 'package:design_system/src/tokens/design_tokens.dart';
import 'package:flutter/material.dart';

class BaseDialog {
  BaseDialog._();

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? description,
    Widget? body,
    String? primaryLabel,
    String? secondaryLabel,
    VoidCallback? onPrimary,
    VoidCallback? onSecondary,
    T? primaryValue,
    T? secondaryValue,
    bool primaryFirst = false,
    bool barrierDismissible = true,
    double? width,
    double? height,
    VoidCallback? onPop,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: DesignSpacingTokens.lg,
            vertical: DesignSpacingTokens.lg,
          ),
          constraints: width == null && height == null
              ? null
              : BoxConstraints.tightFor(width: width, height: height),
          title: title == null
              ? null
              : Row(
                  children: [
                    Text(title),
                    const Spacer(),
                    IconButton(
                      onPressed:
                          onPop ?? () => Navigator.of(dialogContext).pop(),
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      alignment: Alignment.topRight,
                    ),
                  ],
                ),
          content: body ?? (description == null ? null : Text(description)),
          actions: _actions(
            dialogContext: dialogContext,
            primaryLabel: primaryLabel,
            secondaryLabel: secondaryLabel,
            onPrimary: onPrimary,
            onSecondary: onSecondary,
            primaryValue: primaryValue,
            secondaryValue: secondaryValue,
            primaryFirst: primaryFirst,
          ),
        );
      },
    );
  }

  static List<Widget> _actions<T>({
    required BuildContext dialogContext,
    required String? primaryLabel,
    required String? secondaryLabel,
    required VoidCallback? onPrimary,
    required VoidCallback? onSecondary,
    required T? primaryValue,
    required T? secondaryValue,
    required bool primaryFirst,
  }) {
    final primary = primaryLabel == null
        ? null
        : TextButton(
            onPressed: () {
              onPrimary?.call();
              Navigator.of(dialogContext).pop(primaryValue);
            },
            child: Text(primaryLabel),
          );
    final secondary = secondaryLabel == null
        ? null
        : TextButton(
            onPressed: () {
              onSecondary?.call();
              Navigator.of(dialogContext).pop(secondaryValue);
            },
            child: Text(secondaryLabel),
          );

    if (primary == null && secondary == null) {
      return const [];
    }
    if (primary == null) {
      return [secondary!];
    }
    if (secondary == null) {
      return [primary];
    }
    return primaryFirst ? [primary, secondary] : [secondary, primary];
  }
}
