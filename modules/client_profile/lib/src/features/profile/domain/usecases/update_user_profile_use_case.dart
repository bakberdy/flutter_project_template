import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/profile/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

class UpdateUserProfileParams extends Equatable {
  const UpdateUserProfileParams({
    this.fullName,
    this.phoneNumber,
    this.includeFullName = false,
    this.includePhoneNumber = false,
  });
  final String? fullName;
  final UserPhoneNumber? phoneNumber;
  final bool includeFullName;
  final bool includePhoneNumber;

  @override
  List<Object?> get props => [
    fullName,
    phoneNumber,
    includeFullName,
    includePhoneNumber,
  ];
}

@lazySingleton
class UpdateUserProfileUseCase
    extends UseCase<UserProfile, UpdateUserProfileParams> {
  UpdateUserProfileUseCase(this._repository);
  final UserProfileRepository _repository;

  @override
  FutureEither<UserProfile> call(UpdateUserProfileParams params) {
    return trackUserProfileUseCase(
      _repository.updateProfile(
        fullName: params.fullName,
        phoneNumber: params.phoneNumber,
      ),
      'update_profile',
    );
  }
}
