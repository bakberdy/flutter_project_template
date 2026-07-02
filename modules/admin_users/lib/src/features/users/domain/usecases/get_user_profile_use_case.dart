import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';

typedef GetUserProfileParams = ({String userId, ApiCancelToken? cancelToken});

@lazySingleton
class GetUserProfileUseCase
    extends UseCase<AdminUserProfile, GetUserProfileParams> {
  GetUserProfileUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<AdminUserProfile> call(GetUserProfileParams params) =>
      _repository.getUserProfile(
        params.userId,
        cancelToken: params.cancelToken,
      );
}
