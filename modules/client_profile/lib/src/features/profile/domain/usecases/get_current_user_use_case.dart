import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/profile/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

typedef GetCurrentUserParams = ({
  ApiCancelToken? cancelToken,
  Duration? timeout,
});

@lazySingleton
class GetCurrentUserUseCase extends UseCase<User, GetCurrentUserParams> {
  final UserProfileRepository _repository;

  GetCurrentUserUseCase(this._repository);

  @override
  FutureEither<User> call(GetCurrentUserParams params) {
    final result = trackUserProfileUseCase(
      _repository.getCurrentUser(cancelToken: params.cancelToken),
      'get_current_user',
    );
    return params.timeout == null
        ? result
        : result.timeout(
            params.timeout!,
            onTimeout: () => const Left(
              Failure(
                source: 'GetCurrentUserUseCase.timeout',
                details: FailureDetails(statusCode: 0),
              ),
            ),
          );
  }
}
