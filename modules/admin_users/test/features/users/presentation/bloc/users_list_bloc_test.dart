import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';
import 'package:admin_users/src/features/users/domain/usecases/get_users_use_case.dart';
import 'package:admin_users/src/features/users/presentation/blocs/users_list/users_list_bloc.dart';

class UsersListRepositoryFake implements UsersRepository {
  final List<UsersQuery> queries = [];

  @override
  FutureEither<PaginatedResponse<AdminUser>> getUsers(
    UsersQuery query, {
    ApiCancelToken? cancelToken,
  }) async {
    queries.add(query);
    return const Right(
      PaginatedResponse(
        items: [],
        pagination: PaginationMeta(
          page: 1,
          limit: 20,
          totalItems: 0,
          totalPages: 1,
          hasNext: false,
          hasPrevious: false,
        ),
      ),
    );
  }

  @override
  FutureEither<AdminUser> getUser(
    String userId, {
    ApiCancelToken? cancelToken,
  }) async => throw UnimplementedError();

  @override
  FutureEither<AdminUserProfile> getUserProfile(
    String userId, {
    ApiCancelToken? cancelToken,
  }) async => throw UnimplementedError();

  @override
  FutureEither<AdminUser> changeUserStatus(
    String userId,
    AdminUserStatus status,
  ) async => throw UnimplementedError();

  @override
  FutureEither<AdminUser> changeUserRole(
    String userId,
    AdminUserRole role,
  ) async => throw UnimplementedError();

  @override
  FutureEither<AdminUser> approveDeletionRequest(String userId) async =>
      throw UnimplementedError();
}

void main() {
  late UsersListRepositoryFake repository;

  setUp(() {
    repository = UsersListRepositoryFake();
  });

  blocTest<UsersListBloc, UsersListState>(
    'loads users with created-at descending order initially',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    act: (bloc) => bloc.add(const UsersListEvent.started()),
    verify: (_) {
      expect(repository.queries.single.sortField, UsersSortField.createdAt);
      expect(
        repository.queries.single.sortDirection,
        UsersSortDirection.descending,
      );
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'sorts a newly selected column ascending and resets the page',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(
      query: UsersQuery(
        pageNumber: 3,
        status: AdminUserStatus.blocked,
        role: AdminUserRole.admin,
        isVerified: true,
        isProfileCompleted: false,
        search: 'admin@example.com',
      ),
      pagination: PaginationMeta(
        page: 3,
        limit: 20,
        totalItems: 100,
        totalPages: 5,
        hasNext: true,
        hasPrevious: true,
      ),
    ),
    act: (bloc) =>
        bloc.add(const UsersListEvent.sortChanged(UsersSortField.email)),
    verify: (_) {
      final query = repository.queries.single;
      expect(query.pageNumber, 1);
      expect(query.sortField, UsersSortField.email);
      expect(query.sortDirection, UsersSortDirection.ascending);
      expect(query.status, AdminUserStatus.blocked);
      expect(query.role, AdminUserRole.admin);
      expect(query.isVerified, isTrue);
      expect(query.isProfileCompleted, isFalse);
      expect(query.search, 'admin@example.com');
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'toggles the active sort column direction',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(
      query: UsersQuery(
        sortField: UsersSortField.email,
        sortDirection: UsersSortDirection.ascending,
      ),
    ),
    act: (bloc) =>
        bloc.add(const UsersListEvent.sortChanged(UsersSortField.email)),
    verify: (_) {
      expect(
        repository.queries.single.sortDirection,
        UsersSortDirection.descending,
      );
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'searches with a trimmed term and resets the page',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(query: UsersQuery(pageNumber: 3)),
    act: (bloc) =>
        bloc.add(const UsersListEvent.searchSubmitted('  user@example.com  ')),
    verify: (_) {
      final query = repository.queries.single;
      expect(query.pageNumber, 1);
      expect(query.search, 'user@example.com');
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'clears the active search and resets the page',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(
      query: UsersQuery(pageNumber: 3, search: 'user@example.com'),
    ),
    act: (bloc) => bloc.add(const UsersListEvent.searchSubmitted('')),
    verify: (_) {
      final query = repository.queries.single;
      expect(query.pageNumber, 1);
      expect(query.search, isNull);
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'does not request the active search again',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () =>
        const UsersListState(query: UsersQuery(search: 'user@example.com')),
    act: (bloc) =>
        bloc.add(const UsersListEvent.searchSubmitted(' user@example.com ')),
    verify: (_) => expect(repository.queries, isEmpty),
  );

  blocTest<UsersListBloc, UsersListState>(
    'filters by status and resets the page',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(query: UsersQuery(pageNumber: 3)),
    act: (bloc) =>
        bloc.add(const UsersListEvent.statusChanged(AdminUserStatus.active)),
    verify: (_) {
      final query = repository.queries.single;
      expect(query.pageNumber, 1);
      expect(query.status, AdminUserStatus.active);
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'clears the active status and resets the page',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(
      query: UsersQuery(pageNumber: 3, status: AdminUserStatus.active),
    ),
    act: (bloc) => bloc.add(const UsersListEvent.statusChanged(null)),
    verify: (_) {
      final query = repository.queries.single;
      expect(query.pageNumber, 1);
      expect(query.status, isNull);
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'does not request the active status again',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () =>
        const UsersListState(query: UsersQuery(status: AdminUserStatus.active)),
    act: (bloc) =>
        bloc.add(const UsersListEvent.statusChanged(AdminUserStatus.active)),
    verify: (_) => expect(repository.queries, isEmpty),
  );

  blocTest<UsersListBloc, UsersListState>(
    'filters by role and resets the page',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(query: UsersQuery(pageNumber: 3)),
    act: (bloc) =>
        bloc.add(const UsersListEvent.roleChanged(AdminUserRole.admin)),
    verify: (_) {
      final query = repository.queries.single;
      expect(query.pageNumber, 1);
      expect(query.role, AdminUserRole.admin);
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'filters by verification state and resets the page',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(query: UsersQuery(pageNumber: 3)),
    act: (bloc) => bloc.add(const UsersListEvent.isVerifiedChanged(false)),
    verify: (_) {
      final query = repository.queries.single;
      expect(query.pageNumber, 1);
      expect(query.isVerified, isFalse);
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'filters by profile completed state and resets the page',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(query: UsersQuery(pageNumber: 3)),
    act: (bloc) =>
        bloc.add(const UsersListEvent.isProfileCompletedChanged(true)),
    verify: (_) {
      final query = repository.queries.single;
      expect(query.pageNumber, 1);
      expect(query.isProfileCompleted, isTrue);
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'filters by created-at range and resets the page',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(query: UsersQuery(pageNumber: 3)),
    act: (bloc) {
      final from = DateTime.utc(2026, 6, 1);
      final to = DateTime.utc(2026, 6, 24);
      bloc.add(UsersListEvent.createdAtRangeChanged(from: from, to: to));
    },
    verify: (_) {
      final query = repository.queries.single;
      expect(query.pageNumber, 1);
      expect(query.createdAtFrom, DateTime.utc(2026, 6, 1));
      expect(query.createdAtTo, DateTime.utc(2026, 6, 24));
    },
  );

  blocTest<UsersListBloc, UsersListState>(
    'applies filter dialog query in one request and resets the page',
    build: () => UsersListBloc(GetUsersUseCase(repository)),
    seed: () => const UsersListState(query: UsersQuery(pageNumber: 3)),
    act: (bloc) => bloc.add(
      UsersListEvent.filtersChanged(
        UsersQuery(
          pageNumber: 3,
          status: AdminUserStatus.active,
          role: AdminUserRole.admin,
          isVerified: true,
          isProfileCompleted: false,
          createdAtFrom: DateTime.utc(2026, 6, 1),
          createdAtTo: DateTime.utc(2026, 6, 24),
        ),
      ),
    ),
    verify: (_) {
      final query = repository.queries.single;
      expect(query.pageNumber, 1);
      expect(query.status, AdminUserStatus.active);
      expect(query.role, AdminUserRole.admin);
      expect(query.isVerified, isTrue);
      expect(query.isProfileCompleted, isFalse);
      expect(query.createdAtFrom, DateTime.utc(2026, 6, 1));
      expect(query.createdAtTo, DateTime.utc(2026, 6, 24));
    },
  );
}
