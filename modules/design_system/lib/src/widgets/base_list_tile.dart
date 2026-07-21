import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:design_system/src/tokens/design_tokens.dart';
import 'package:flutter/material.dart';

class BaseListTile extends StatelessWidget {
  const BaseListTile({
    required this.title,
    super.key,
    this.onTap,
    this.subtitle,
    this.leading,
    this.trailing,
    this.foregroundColor,
    this.disableTopRadius = false,
    this.disableBottomRadius = false,
    this.padding,
    this.margin,
  });
  final VoidCallback? onTap;
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;

  final bool disableTopRadius;
  final bool disableBottomRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    const defaultRadiues = Radius.circular(DesignRadiusTokens.lg);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: disableTopRadius ? Radius.zero : defaultRadiues,
          bottom: disableBottomRadius ? Radius.zero : defaultRadiues,
        ),
      ),
      margin:
          margin ??
          const EdgeInsets.symmetric(horizontal: DesignSpacingTokens.md),
      child: InkWell(
        borderRadius: BorderRadius.vertical(
          top: disableTopRadius ? Radius.zero : defaultRadiues,
          bottom: disableBottomRadius ? Radius.zero : defaultRadiues,
        ),
        onTap: onTap,
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: DesignSpacingTokens.sm,
                vertical: DesignSpacingTokens.sm,
              ),
          child: Row(
            children: [
              ?leading,
              const SizedBox(width: DesignSpacingTokens.sm),
              if (subtitle != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        softWrap: true,
                        title,
                        style: context.designTextTheme.titleMedium?.copyWith(
                          color: foregroundColor,
                        ),
                      ),
                      Text(
                        softWrap: true,
                        subtitle!,
                        style: context.designTextTheme.bodySmall?.copyWith(
                          color: foregroundColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Text(
                  title,
                  style: context.designTextTheme.titleMedium?.copyWith(
                    color: foregroundColor,
                  ),
                ),
              const Spacer(),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
