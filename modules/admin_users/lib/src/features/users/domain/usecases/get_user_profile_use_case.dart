import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';
import 'package:admin_users/src/features/users/domain/usecases/admin_users_use_case_tracking.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserProfileUseCase extends UseCase<AdminUserProfile, String> {
  GetUserProfileUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<AdminUserProfile> call(String params) => trackAdminUsersUseCase(
    _repository.getUserProfile(params),
    'get_user_profile',
    properties: {'target_user_id': params},
  );
}
