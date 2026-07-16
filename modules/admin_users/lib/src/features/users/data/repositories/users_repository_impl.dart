import 'package:admin_users/src/features/users/data/datasources/users_remote_data_source.dart';
import 'package:admin_users/src/features/users/data/services/users_repository_request_handler.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {
  const UsersRepositoryImpl(this._remoteDataSource, this._handler);

  final UsersRemoteDataSource _remoteDataSource;
  final UsersRepositoryRequestHandler _handler;

  @override
  FutureEither<PaginatedResponse<AdminUser>> getUsers(UsersQuery query) =>
      _handler.execute(() async {
        final response = await _remoteDataSource.getUsers(query);
        return PaginatedResponse<AdminUser>(
          items: response.items,
          pagination: response.pagination,
        );
      }, source: '$runtimeType.getUsers');

  @override
  FutureEither<AdminUser> getUser(String userId) => _handler.execute(
    () => _remoteDataSource.getUser(userId),
    source: '$runtimeType.getUser',
  );

  @override
  FutureEither<AdminUserProfile> getUserProfile(String userId) =>
      _handler.execute(
        () => _remoteDataSource.getUserProfile(userId),
        source: '$runtimeType.getUserProfile',
      );

  @override
  FutureEither<AdminUser> changeUserStatus(
    String userId,
    AdminUserStatus status,
  ) => _handler.execute(
    () => _remoteDataSource.changeUserStatus(userId, status),
    source: '$runtimeType.changeUserStatus',
  );

  @override
  FutureEither<AdminUser> changeUserRole(String userId, AdminUserRole role) =>
      _handler.execute(
        () => _remoteDataSource.changeUserRole(userId, role),
        source: '$runtimeType.changeUserRole',
      );

  @override
  FutureEither<AdminUser> approveDeletionRequest(String userId) =>
      _handler.execute(
        () => _remoteDataSource.approveDeletionRequest(userId),
        source: '$runtimeType.approveDeletionRequest',
      );
}
