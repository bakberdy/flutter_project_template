import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/presentation/extensions/admin_user_localization_x.dart';
import 'package:admin_users/src/common/admin_users_context_x.dart';

class UsersStatusFilter extends StatelessWidget {
  const UsersStatusFilter({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final AdminUserStatus? value;
  final ValueChanged<AdminUserStatus?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selectedLabel =
        value?.localizedName(l10n) ?? l10n.usersStatusFilterAll;
    final colorScheme = context.designColors;
    final borderColor = !enabled
        ? colorScheme.outlineVariant
        : value == null
        ? colorScheme.outlineVariant
        : colorScheme.primary;
    final foregroundColor = !enabled
        ? colorScheme.onSurface.withValues(alpha: 0.38)
        : value == null
        ? colorScheme.onSurfaceVariant
        : colorScheme.primary;
    final backgroundColor = !enabled || value == null
        ? colorScheme.surface
        : colorScheme.primaryContainer.withValues(alpha: 0.24);
    final borderRadius = BorderRadius.circular(DesignRadiusTokens.md);

    return PopupMenuButton<AdminUserStatus?>(
      enabled: enabled,
      tooltip: l10n.usersStatusFilterLabel,
      offset: const Offset(0, DesignSpacingTokens.xs),
      initialValue: value,
      onSelected: onChanged,
      borderRadius: borderRadius,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      itemBuilder: (context) => [
        PopupMenuItem<AdminUserStatus?>(
          value: null,
          child: Text(l10n.usersStatusFilterAll),
        ),
        ...AdminUserStatus.values.map(
          (status) => PopupMenuItem<AdminUserStatus?>(
            value: status,
            child: Text(status.localizedName(l10n)),
          ),
        ),
      ],
      child: SizedBox(
        width: 172,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(
            horizontal: DesignSpacingTokens.sm,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Icon(Icons.filter_list, size: 18, color: foregroundColor),
              const SizedBox(width: DesignSpacingTokens.xs),
              Expanded(
                child: Text(
                  selectedLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.designTextTheme.bodyMedium?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: DesignSpacingTokens.xs),
              Icon(Icons.expand_more, size: 18, color: foregroundColor),
            ],
          ),
        ),
      ),
    );
  }
}
