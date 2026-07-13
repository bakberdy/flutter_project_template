import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:admin_users/src/common/admin_users_localization_x.dart';

class UsersPagination extends StatelessWidget {
  const UsersPagination({
    super.key,
    required this.pagination,
    required this.onPageChanged,
    this.loading = false,
  });

  final PaginationMeta pagination;
  final ValueChanged<int> onPageChanged;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BaseButton.secondary(
          onPressed: pagination.hasPrevious
              ? () => onPageChanged(pagination.page - 1)
              : null,
          disabled: loading || !pagination.hasPrevious,
          label: l10n.usersPreviousPage,
          leadingIcon: const Icon(Icons.chevron_left),
        ),
        const SizedBox(width: AppSpacing.md),
        Text(l10n.usersPagination(pagination.page, pagination.totalPages)),
        const SizedBox(width: AppSpacing.md),
        BaseButton.secondary(
          onPressed: pagination.hasNext
              ? () => onPageChanged(pagination.page + 1)
              : null,
          disabled: loading || !pagination.hasNext,
          label: l10n.usersNextPage,
          trailingIcon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
