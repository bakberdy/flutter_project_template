import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/profile/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

typedef GetCurrentUserParams = ({
  ApiCancelToken? cancelToken,
  Duration? timeout,
});

@lazySingleton
class GetCurrentUserUseCase extends UseCase<User?, GetCurrentUserParams> {
  GetCurrentUserUseCase(this._repository);
  final UserProfileRepository _repository;

  @override
  FutureEither<User?> call(GetCurrentUserParams params) async {
    if (!await _repository.hasSession()) {
      return const Right(null);
    }

    final result = trackUserProfileUseCase(
      _repository.getCurrentUser(cancelToken: params.cancelToken),
      'get_current_user',
    );
    final timeout = params.timeout;
    return timeout == null
        ? result
        : result.timeout(
            timeout,
            onTimeout: () => const Left(
              TimeoutFailure(
                source: 'GetCurrentUserUseCase.timeout',
                details: FailureDetails(statusCode: 0),
              ),
            ),
          );
  }
}
