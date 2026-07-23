import 'package:admin_users/src/common/presentation/extensions/admin_users_context_x.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:admin_users/src/features/users/presentation/extensions/admin_user_localization_x.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared/shared.dart';

class UsersActiveFiltersBar extends StatelessWidget {
  const UsersActiveFiltersBar({
    required this.query,
    required this.onStatusCleared,
    required this.onRoleCleared,
    required this.onIsVerifiedCleared,
    required this.onIsProfileCompletedCleared,
    required this.onCreatedAtRangeCleared,
    super.key,
  });

  final UsersQuery query;
  final VoidCallback onStatusCleared;
  final VoidCallback onRoleCleared;
  final VoidCallback onIsVerifiedCleared;
  final VoidCallback onIsProfileCompletedCleared;
  final VoidCallback onCreatedAtRangeCleared;

  @override
  Widget build(BuildContext context) {
    if (!query.hasFilters) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    return Wrap(
      spacing: DesignSpacingTokens.xs,
      runSpacing: DesignSpacingTokens.xs,
      children: [
        if (query.status case final UserStatus status)
          _FilterChip(
            label: l10n.usersActiveFilter(
              l10n.usersStatusFilterLabel,
              status.localizedName(l10n),
            ),
            onDeleted: onStatusCleared,
          ),
        if (query.role case final UserRole role)
          _FilterChip(
            label: l10n.usersActiveFilter(
              l10n.usersRoleFilterLabel,
              role.localizedName(l10n),
            ),
            onDeleted: onRoleCleared,
          ),
        if (query.isVerified case final bool isVerified)
          _FilterChip(
            label: l10n.usersActiveFilter(
              l10n.usersVerifiedFilterLabel,
              isVerified ? l10n.usersYes : l10n.usersNo,
            ),
            onDeleted: onIsVerifiedCleared,
          ),
        if (query.isProfileCompleted case final bool isProfileCompleted)
          _FilterChip(
            label: l10n.usersActiveFilter(
              l10n.usersProfileCompletedFilterLabel,
              isProfileCompleted ? l10n.usersYes : l10n.usersNo,
            ),
            onDeleted: onIsProfileCompletedCleared,
          ),
        if (query.createdAtFrom != null || query.createdAtTo != null)
          _FilterChip(
            label: l10n.usersActiveFilter(
              l10n.usersColumnCreatedAt,
              _dateRangeLabel(context, query),
            ),
            onDeleted: onCreatedAtRangeCleared,
          ),
      ],
    );
  }

  String _dateRangeLabel(BuildContext context, UsersQuery query) {
    final format = DateFormat.yMd(Localizations.localeOf(context).toString());
    final createdAtFrom = query.createdAtFrom;
    final createdAtTo = query.createdAtTo;
    final start = createdAtFrom == null
        ? ''
        : format.format(createdAtFrom.toLocal());
    final end = createdAtTo == null ? '' : format.format(createdAtTo.toLocal());
    return '$start - $end';
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.onDeleted});

  final String label;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(Icons.close, size: 16),
      onDeleted: onDeleted,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      side: BorderSide(color: context.designColors.outlineVariant),
    );
  }
}
