import 'package:design_system/src/buttons/base_button.dart';
import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:flutter/material.dart';

class BaseRetryErrorView extends StatelessWidget {
  const BaseRetryErrorView({
    required this.title,
    required this.message,
    required this.retryLabel,
    required this.onRetry,
    this.icon = const Icon(Icons.error_outline, size: 48),
    super.key,
  });

  final String title;
  final String message;
  final String retryLabel;
  final VoidCallback onRetry;
  final Widget icon;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.designColors.surface,
    child: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: EdgeInsets.all(context.designSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                SizedBox(height: context.designSpacing.lg),
                Text(
                  title,
                  style: context.designTextTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.designSpacing.sm),
                Text(
                  message,
                  style: context.designTextTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.designSpacing.lg),
                BaseButton.primary(
                  onPressed: onRetry,
                  label: retryLabel,
                  leadingIcon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
