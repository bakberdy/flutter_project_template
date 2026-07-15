import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';
import 'package:admin_users/src/features/users/domain/usecases/admin_users_use_case_tracking.dart';

@lazySingleton
class GetUserUseCase extends UseCase<AdminUser, String> {
  GetUserUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<AdminUser> call(String params) => trackAdminUsersUseCase(
    _repository.getUser(params),
    'get_user',
    properties: {'target_user_id': params},
  );
}
