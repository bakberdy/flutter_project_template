import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';

@lazySingleton
class GetUserProfileUseCase extends UseCase<AdminUserProfile, String> {
  GetUserProfileUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<AdminUserProfile> call(String params) =>
      _repository.getUserProfile(params);
}
