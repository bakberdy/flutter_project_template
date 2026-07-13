import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:admin_users/src/features/users/presentation/extensions/admin_user_localization_x.dart';
import 'package:admin_users/src/common/admin_users_context_x.dart';

class UsersActiveFiltersBar extends StatelessWidget {
  const UsersActiveFiltersBar({
    super.key,
    required this.query,
    required this.onStatusCleared,
    required this.onRoleCleared,
    required this.onIsVerifiedCleared,
    required this.onIsProfileCompletedCleared,
    required this.onCreatedAtRangeCleared,
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
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        if (query.status case final AdminUserStatus status)
          _FilterChip(
            label:
                '${l10n.usersStatusFilterLabel}: ${status.localizedName(l10n)}',
            onDeleted: onStatusCleared,
          ),
        if (query.role case final AdminUserRole role)
          _FilterChip(
            label: '${l10n.usersRoleFilterLabel}: ${role.localizedName(l10n)}',
            onDeleted: onRoleCleared,
          ),
        if (query.isVerified case final bool isVerified)
          _FilterChip(
            label:
                '${l10n.usersVerifiedFilterLabel}: ${isVerified ? l10n.usersYes : l10n.usersNo}',
            onDeleted: onIsVerifiedCleared,
          ),
        if (query.isProfileCompleted case final bool isProfileCompleted)
          _FilterChip(
            label:
                '${l10n.usersProfileCompletedFilterLabel}: ${isProfileCompleted ? l10n.usersYes : l10n.usersNo}',
            onDeleted: onIsProfileCompletedCleared,
          ),
        if (query.createdAtFrom != null || query.createdAtTo != null)
          _FilterChip(
            label:
                '${l10n.usersColumnCreatedAt}: ${_dateRangeLabel(context, query)}',
            onDeleted: onCreatedAtRangeCleared,
          ),
      ],
    );
  }

  String _dateRangeLabel(BuildContext context, UsersQuery query) {
    final format = DateFormat.yMd(Localizations.localeOf(context).toString());
    final start = query.createdAtFrom == null
        ? ''
        : format.format(query.createdAtFrom!.toLocal());
    final end = query.createdAtTo == null
        ? ''
        : format.format(query.createdAtTo!.toLocal());
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
      side: BorderSide(color: context.colorScheme.outlineVariant),
    );
  }
}
