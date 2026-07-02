import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';

typedef ChangeUserStatusParams = ({String userId, AdminUserStatus status});

@lazySingleton
class ChangeUserStatusUseCase
    extends UseCase<AdminUser, ChangeUserStatusParams> {
  ChangeUserStatusUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<AdminUser> call(ChangeUserStatusParams params) =>
      _repository.changeUserStatus(params.userId, params.status);
}
