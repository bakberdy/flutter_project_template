import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

typedef AdminSessionResult = ({User? user, bool accessDenied});

@lazySingleton
class GetAdminSessionUseCase extends UseCase<AdminSessionResult, NoParams> {
  GetAdminSessionUseCase(this._repository);

  final AuthRepository _repository;

  @override
  FutureEither<AdminSessionResult> call(NoParams params) async {
    if (!await _repository.hasSession()) {
      return const Right((user: null, accessDenied: false));
    }

    final result = await _repository.getCurrentUser();
    return result.fold(Left.new, (user) async {
      if (user.role == UserRole.user) {
        await _repository.clearSession();
        return const Right((user: null, accessDenied: true));
      }
      return Right((user: user, accessDenied: false));
    });
  }
}
