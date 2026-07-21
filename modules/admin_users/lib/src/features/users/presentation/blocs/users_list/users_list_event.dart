part of 'users_list_bloc.dart';

@freezed
sealed class UsersListEvent with _$UsersListEvent {
  const factory UsersListEvent.started() = _Started;
  const factory UsersListEvent.refreshed() = _Refreshed;
  const factory UsersListEvent.sortChanged(UsersSortField field) = _SortChanged;
  const factory UsersListEvent.searchSubmitted(String search) =
      _SearchSubmitted;
  const factory UsersListEvent.statusChanged(AdminUserStatus? status) =
      _StatusChanged;
  const factory UsersListEvent.roleChanged(AdminUserRole? role) = _RoleChanged;
  const factory UsersListEvent.isVerifiedChanged({bool? isVerified}) =
      _IsVerifiedChanged;
  const factory UsersListEvent.isProfileCompletedChanged({
    bool? isProfileCompleted,
  }) = _IsProfileCompletedChanged;
  const factory UsersListEvent.createdAtRangeChanged({
    DateTime? from,
    DateTime? to,
  }) = _CreatedAtRangeChanged;
  const factory UsersListEvent.filtersChanged(UsersQuery query) =
      _FiltersChanged;
  const factory UsersListEvent.pageChanged(int pageNumber) = _PageChanged;
}
