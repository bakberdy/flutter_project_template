part of 'users_list_bloc.dart';

@freezed
sealed class UsersListState with _$UsersListState {
  const factory UsersListState({
    @Default(<AdminUser>[]) List<AdminUser> users,
    @Default(UsersQuery()) UsersQuery query,
    @Default(StateStatus.initial()) StateStatus status,
    PaginationMeta? pagination,
  }) = _UsersListState;
}
