import 'package:design_system/src/tokens/design_tokens.dart';
import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.showCopyIcon = true,
  });
  final String label;
  final String value;
  final bool showCopyIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.designTextTheme.labelLarge?.copyWith(
            color: context.designColors.onSurface,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        // SizedBox(height: AppSpacing.xxs),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectableText(value, style: context.designTextTheme.bodyLarge),
            if (showCopyIcon) ...[
              SizedBox(width: DesignTokens.spacing.xs),
              InkWell(
                onTap: () => Clipboard.setData(ClipboardData(text: value)),
                child: Icon(
                  Icons.copy_outlined,
                  size: 16,
                  color: context.designColors.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
