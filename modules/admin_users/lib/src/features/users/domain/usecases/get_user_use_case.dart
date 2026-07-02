import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';

typedef GetUserParams = ({String userId, ApiCancelToken? cancelToken});

@lazySingleton
class GetUserUseCase extends UseCase<AdminUser, GetUserParams> {
  GetUserUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<AdminUser> call(GetUserParams params) =>
      _repository.getUser(params.userId, cancelToken: params.cancelToken);
}
