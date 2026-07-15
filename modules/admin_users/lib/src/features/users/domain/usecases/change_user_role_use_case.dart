import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';
import 'package:admin_users/src/features/users/domain/usecases/admin_users_use_case_tracking.dart';

typedef ChangeUserRoleParams = ({String userId, AdminUserRole role});

@lazySingleton
class ChangeUserRoleUseCase extends UseCase<AdminUser, ChangeUserRoleParams> {
  ChangeUserRoleUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<AdminUser> call(ChangeUserRoleParams params) =>
      trackAdminUsersUseCase(
        _repository.changeUserRole(params.userId, params.role),
        'change_role',
        properties: {'target_user_id': params.userId, 'role': params.role.name},
      );
}
