import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';
import 'package:admin_users/src/features/users/domain/usecases/admin_users_use_case_tracking.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@lazySingleton
class GetUserUseCase extends UseCase<User, String> {
  GetUserUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<User> call(String params) => trackAdminUsersUseCase(
    _repository.getUser(params),
    'get_user',
    properties: {'target_user_id': params},
  );
}
