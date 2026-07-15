import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';
import 'package:admin_users/src/features/users/domain/usecases/admin_users_use_case_tracking.dart';

@lazySingleton
class GetUsersUseCase
    extends UseCase<PaginatedResponse<AdminUser>, UsersQuery> {
  GetUsersUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<PaginatedResponse<AdminUser>> call(UsersQuery params) =>
      trackAdminUsersUseCase(
        _repository.getUsers(params),
        'get_users',
        properties: {
          'page_number': params.pageNumber,
          'limit': params.limit,
          'sort_field': params.sortField.name,
          'sort_direction': params.sortDirection.name,
          'status': ?params.status?.name,
          'role': ?params.role?.name,
          'is_verified': ?params.isVerified,
          'is_profile_completed': ?params.isProfileCompleted,
          'has_created_at_from': params.createdAtFrom != null,
          'has_created_at_to': params.createdAtTo != null,
          'has_search': params.search?.trim().isNotEmpty ?? false,
        },
      );
}
