import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';

typedef GetUsersParams = ({UsersQuery query, ApiCancelToken? cancelToken});

@lazySingleton
class GetUsersUseCase
    extends UseCase<PaginatedResponse<AdminUser>, GetUsersParams> {
  GetUsersUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<PaginatedResponse<AdminUser>> call(GetUsersParams params) =>
      _repository.getUsers(params.query, cancelToken: params.cancelToken);
}
