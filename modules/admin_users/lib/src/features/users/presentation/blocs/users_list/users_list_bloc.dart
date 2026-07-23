import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:admin_users/src/features/users/domain/usecases/get_users_use_case.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

part 'users_list_bloc.freezed.dart';
part 'users_list_event.dart';
part 'users_list_state.dart';

@injectable
class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  UsersListBloc(this._getUsersUseCase) : super(const UsersListState()) {
    on<_Started>(_onStarted, transformer: restartable());
    on<_Refreshed>(_onRefreshed, transformer: restartable());
    on<_SortChanged>(_onSortChanged, transformer: restartable());
    on<_SearchSubmitted>(_onSearchSubmitted, transformer: restartable());
    on<_StatusChanged>(_onStatusChanged, transformer: restartable());
    on<_RoleChanged>(_onRoleChanged, transformer: restartable());
    on<_IsVerifiedChanged>(_onIsVerifiedChanged, transformer: restartable());
    on<_IsProfileCompletedChanged>(
      _onIsProfileCompletedChanged,
      transformer: restartable(),
    );
    on<_CreatedAtRangeChanged>(
      _onCreatedAtRangeChanged,
      transformer: restartable(),
    );
    on<_FiltersChanged>(_onFiltersChanged, transformer: restartable());
    on<_PageChanged>(_onPageChanged, transformer: restartable());
  }

  final GetUsersUseCase _getUsersUseCase;

  Future<void> _onStarted(_Started event, Emitter<UsersListState> emit) =>
      _load(state.query, emit);

  Future<void> _onRefreshed(_Refreshed event, Emitter<UsersListState> emit) =>
      _load(state.query, emit);

  Future<void> _onSortChanged(
    _SortChanged event,
    Emitter<UsersListState> emit,
  ) {
    final direction = event.field == state.query.sortField
        ? switch (state.query.sortDirection) {
            UsersSortDirection.ascending => UsersSortDirection.descending,
            UsersSortDirection.descending => UsersSortDirection.ascending,
          }
        : UsersSortDirection.ascending;
    return _load(
      state.query.copyWith(
        pageNumber: 1,
        sortField: event.field,
        sortDirection: direction,
      ),
      emit,
    );
  }

  Future<void> _onPageChanged(
    _PageChanged event,
    Emitter<UsersListState> emit,
  ) {
    final pagination = state.pagination;
    if (event.pageNumber < 1 ||
        pagination == null ||
        event.pageNumber > pagination.totalPages) {
      return Future<void>.value();
    }
    return _load(state.query.copyWith(pageNumber: event.pageNumber), emit);
  }

  Future<void> _onSearchSubmitted(
    _SearchSubmitted event,
    Emitter<UsersListState> emit,
  ) {
    final search = event.search.trim();
    final nextSearch = search.isEmpty ? null : search;
    if (nextSearch == state.query.search) {
      return Future<void>.value();
    }
    return _load(
      state.query.copyWithSearch(nextSearch).copyWith(pageNumber: 1),
      emit,
    );
  }

  Future<void> _onStatusChanged(
    _StatusChanged event,
    Emitter<UsersListState> emit,
  ) {
    if (event.status == state.query.status) {
      return Future<void>.value();
    }
    return _load(
      state.query
          .copyWithFilters(
            status: event.status,
            clearStatus: event.status == null,
          )
          .copyWith(pageNumber: 1),
      emit,
    );
  }

  Future<void> _onRoleChanged(
    _RoleChanged event,
    Emitter<UsersListState> emit,
  ) {
    if (event.role == state.query.role) {
      return Future<void>.value();
    }
    return _load(
      state.query
          .copyWithFilters(role: event.role, clearRole: event.role == null)
          .copyWith(pageNumber: 1),
      emit,
    );
  }

  Future<void> _onIsVerifiedChanged(
    _IsVerifiedChanged event,
    Emitter<UsersListState> emit,
  ) {
    if (event.isVerified == state.query.isVerified) {
      return Future<void>.value();
    }
    return _load(
      state.query
          .copyWithFilters(
            isVerified: event.isVerified,
            clearIsVerified: event.isVerified == null,
          )
          .copyWith(pageNumber: 1),
      emit,
    );
  }

  Future<void> _onIsProfileCompletedChanged(
    _IsProfileCompletedChanged event,
    Emitter<UsersListState> emit,
  ) {
    if (event.isProfileCompleted == state.query.isProfileCompleted) {
      return Future<void>.value();
    }
    return _load(
      state.query
          .copyWithFilters(
            isProfileCompleted: event.isProfileCompleted,
            clearIsProfileCompleted: event.isProfileCompleted == null,
          )
          .copyWith(pageNumber: 1),
      emit,
    );
  }

  Future<void> _onCreatedAtRangeChanged(
    _CreatedAtRangeChanged event,
    Emitter<UsersListState> emit,
  ) {
    if (event.from == state.query.createdAtFrom &&
        event.to == state.query.createdAtTo) {
      return Future<void>.value();
    }
    return _load(
      state.query
          .copyWithFilters(
            createdAtFrom: event.from,
            clearCreatedAtFrom: event.from == null,
            createdAtTo: event.to,
            clearCreatedAtTo: event.to == null,
          )
          .copyWith(pageNumber: 1),
      emit,
    );
  }

  Future<void> _onFiltersChanged(
    _FiltersChanged event,
    Emitter<UsersListState> emit,
  ) {
    final query = event.query.copyWith(pageNumber: 1);
    if (query == state.query) {
      return Future<void>.value();
    }
    return _load(query, emit);
  }

  Future<void> _load(UsersQuery query, Emitter<UsersListState> emit) async {
    emit(state.copyWith(status: const StateStatus.loading(), query: query));

    final result = await _getUsersUseCase(query);
    result.fold(
      (failure) {
        if (failure.details?.type == FailureType.silent) {
          return;
        }
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (response) => emit(
        state.copyWith(
          status: const StateStatus.success(),
          users: response.items,
          pagination: response.pagination,
        ),
      ),
    );
  }
}
