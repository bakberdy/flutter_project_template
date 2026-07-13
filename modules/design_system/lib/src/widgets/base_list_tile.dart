import 'package:design_system/src/tokens/design_radii.dart';
import 'package:design_system/src/tokens/design_spacing.dart';
import 'package:flutter/material.dart';

class BaseListTile extends StatelessWidget {
  const BaseListTile({
    super.key,
    this.onTap,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.foregroundColor,
    this.disableTopRadius = false,
    this.disableBottomRadius = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: DesignSpacing.sm,
      vertical: DesignSpacing.sm,
    ),
    this.margin = const EdgeInsets.symmetric(horizontal: DesignSpacing.md),
  });
  final VoidCallback? onTap;
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;

  final bool disableTopRadius;
  final bool disableBottomRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    const defaultRadiues = Radius.circular(DesignRadii.lg);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: disableTopRadius ? Radius.zero : defaultRadiues,
          bottom: disableBottomRadius ? Radius.zero : defaultRadiues,
        ),
      ),
      margin: margin,
      child: InkWell(
        borderRadius: BorderRadius.vertical(
          top: disableTopRadius ? Radius.zero : defaultRadiues,
          bottom: disableBottomRadius ? Radius.zero : defaultRadiues,
        ),
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              ?leading,
              const SizedBox(width: DesignSpacing.sm),
              subtitle != null
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: foregroundColor),
                          ),
                          Text(
                            softWrap: true,
                            subtitle!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: foregroundColor),
                          ),
                        ],
                      ),
                    )
                  : Text(
                      title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: foregroundColor),
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
