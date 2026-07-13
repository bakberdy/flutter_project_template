import 'package:core/core.dart';
import 'package:client_profile/src/features/users/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/users/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:injectable/injectable.dart';

class CreateUserProfileParams {
  final String fullName;
  final UserPhoneNumber? phoneNumber;

  const CreateUserProfileParams({required this.fullName, this.phoneNumber});
}

@lazySingleton
class CreateUserProfileUseCase
    extends UseCase<UserProfile, CreateUserProfileParams> {
  final UserProfileRepository _repository;

  CreateUserProfileUseCase(this._repository);

  @override
  FutureEither<UserProfile> call(CreateUserProfileParams params) {
    return trackUserProfileUseCase(
      _repository.createProfile(
        fullName: params.fullName,
        phoneNumber: params.phoneNumber,
      ),
      'create_profile',
    );
  }
}
