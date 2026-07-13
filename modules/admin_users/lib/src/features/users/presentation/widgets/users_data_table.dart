import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:admin_users/src/common/config/router/admin_users_router.dart';
import 'package:admin_users/src/features/users/presentation/extensions/admin_user_localization_x.dart';
import 'package:admin_users/src/features/users/presentation/widgets/user_status_card.dart';
import 'package:admin_users/src/features/users/presentation/widgets/user_verified_icon.dart';
import 'package:admin_users/src/common/admin_users_localization_x.dart';

class UsersDataTable extends StatelessWidget {
  const UsersDataTable({
    super.key,
    required this.users,
    required this.query,
    required this.onSortChanged,
  });

  final List<AdminUser> users;
  final UsersQuery query;
  final ValueChanged<UsersSortField> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.adminUsersL10n;
    final dateFormat = DateFormat.yMd(l10n.localeName).add_Hm();
    return DataTable(
      showCheckboxColumn: false,
      headingTextStyle: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      sortColumnIndex: switch (query.sortField) {
        UsersSortField.email => 0,
        UsersSortField.role => 1,
        UsersSortField.status => 2,
        UsersSortField.isVerified => 3,
        UsersSortField.createdAt => 5,
        UsersSortField.fullName || UsersSortField.phoneNumber => null,
      },
      sortAscending: query.sortDirection == UsersSortDirection.ascending,
      columns: [
        DataColumn(
          label: Expanded(
            child: Text(
              l10n.usersColumnEmail,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          tooltip: l10n.usersColumnEmail,
          columnWidth: const FlexColumnWidth(2),
          onSort: (_, _) => onSortChanged(UsersSortField.email),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              l10n.usersColumnRole,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          tooltip: l10n.usersColumnRole,
          columnWidth: const FlexColumnWidth(),
          onSort: (_, _) => onSortChanged(UsersSortField.role),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              l10n.usersColumnStatus,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          tooltip: l10n.usersColumnStatus,
          columnWidth: const FlexColumnWidth(),
          onSort: (_, _) => onSortChanged(UsersSortField.status),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              l10n.usersColumnVerified,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          tooltip: l10n.usersColumnVerified,
          columnWidth: const FlexColumnWidth(),
          onSort: (_, _) => onSortChanged(UsersSortField.isVerified),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              l10n.usersColumnProfileCompleted,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          tooltip: l10n.usersColumnProfileCompleted,
          columnWidth: const FlexColumnWidth(),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              l10n.usersColumnCreatedAt,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          tooltip: l10n.usersColumnCreatedAt,
          columnWidth: const FlexColumnWidth(1),
          onSort: (_, _) => onSortChanged(UsersSortField.createdAt),
        ),
      ],
      rows: users
          .map(
            (user) => DataRow(
              onSelectChanged: (selected) async {
                if (!(selected ?? false)) {
                  return;
                }
                context.read<CoreNavigationBloc>().add(
                  CoreNavigationEvent.push(UserRoute(userId: user.id)),
                );
              },
              cells: [
                DataCell(
                  Text(
                    user.email,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataCell(Text(user.role.localizedName(l10n))),
                DataCell(UserStatusChip(status: user.status)),
                DataCell(UserVerifiedIcon(verified: user.isVerified)),
                DataCell(
                  Text(user.isUserDataUploaded ? l10n.usersYes : l10n.usersNo),
                ),
                DataCell(Text(dateFormat.format(user.createdAt.toLocal()))),
              ],
            ),
          )
          .toList(),
    );
  }
}
