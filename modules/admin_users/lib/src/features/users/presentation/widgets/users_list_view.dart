import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_users/src/features/users/presentation/widgets/users_active_filters_bar.dart';
import 'package:admin_users/src/features/users/presentation/blocs/users_list/users_list_bloc.dart';
import 'package:admin_users/src/features/users/presentation/widgets/users_data_table.dart';
import 'package:admin_users/src/features/users/presentation/widgets/users_filters_menu_button.dart';
import 'package:admin_users/src/features/users/presentation/widgets/users_pagination.dart';
import 'package:admin_users/src/features/users/presentation/widgets/users_search_bar.dart';
import 'package:admin_users/src/common/admin_users_localization_x.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<UsersListBloc, UsersListState>(
      builder: (context, state) {
        final loading = state.status.isLoading;
        final failure = switch (state.status) {
          ErrorStateStatus(:final failure) => failure,
          _ => null,
        };
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.usersTitle,
                      style: context.textTheme.headlineMedium,
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.usersRefresh,
                    onPressed: loading
                        ? null
                        : () => context.read<UsersListBloc>().add(
                            const UsersListEvent.refreshed(),
                          ),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: UsersSearchBar(
                      initialValue: state.query.search,
                      activeSearch: state.query.search,
                      onSearch: (search) => context.read<UsersListBloc>().add(
                        UsersListEvent.searchSubmitted(search),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  UsersFiltersMenuButton(
                    query: state.query,
                    enabled: !loading,
                    onChanged: (query) => context.read<UsersListBloc>().add(
                      UsersListEvent.filtersChanged(query),
                    ),
                  ),
                ],
              ),
              if (state.query.hasFilters) ...[
                const SizedBox(height: AppSpacing.sm),
                UsersActiveFiltersBar(
                  query: state.query,
                  onStatusCleared: () => context.read<UsersListBloc>().add(
                    const UsersListEvent.statusChanged(null),
                  ),
                  onRoleCleared: () => context.read<UsersListBloc>().add(
                    const UsersListEvent.roleChanged(null),
                  ),
                  onIsVerifiedCleared: () => context.read<UsersListBloc>().add(
                    const UsersListEvent.isVerifiedChanged(null),
                  ),
                  onIsProfileCompletedCleared: () =>
                      context.read<UsersListBloc>().add(
                        const UsersListEvent.isProfileCompletedChanged(null),
                      ),
                  onCreatedAtRangeCleared: () => context
                      .read<UsersListBloc>()
                      .add(const UsersListEvent.createdAtRangeChanged()),
                ),
              ],
              if (state.query.search case final search?) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.usersSearchResults(search),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              if (loading) const LinearProgressIndicator(),
              if (!loading) const SizedBox(height: AppSpacing.xxs),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: switch ((state.users.isEmpty, loading, failure)) {
                  (true, true, _) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  (true, false, final Failure error) => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(error.message ?? l10n.usersLoadFailed),
                        const SizedBox(height: AppSpacing.md),
                        BaseButton.secondary(
                          onPressed: () => context.read<UsersListBloc>().add(
                            const UsersListEvent.refreshed(),
                          ),
                          label: l10n.usersRetry,
                        ),
                      ],
                    ),
                  ),
                  (true, false, _) => Center(child: Text(l10n.usersEmpty)),
                  _ => UsersDataTable(
                    users: state.users,
                    query: state.query,
                    onSortChanged: (field) => context.read<UsersListBloc>().add(
                      UsersListEvent.sortChanged(field),
                    ),
                  ),
                },
              ),
              if (state.pagination case final pagination?) ...[
                const SizedBox(height: AppSpacing.md),
                UsersPagination(
                  pagination: pagination,
                  loading: loading,
                  onPageChanged: (pageNumber) => context
                      .read<UsersListBloc>()
                      .add(UsersListEvent.pageChanged(pageNumber)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
