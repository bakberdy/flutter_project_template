import 'package:admin_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:admin_profile/src/features/profile/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

class CreateUserProfileParams {

  const CreateUserProfileParams({required this.fullName, this.phoneNumber});
  final String fullName;
  final UserPhoneNumber? phoneNumber;
}

@lazySingleton
class CreateUserProfileUseCase
    extends UseCase<UserProfile, CreateUserProfileParams> {

  CreateUserProfileUseCase(this._repository);
  final UserProfileRepository _repository;

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
