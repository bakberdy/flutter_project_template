import 'package:core/core.dart';
import 'package:client_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:client_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetUserPreferencesUseCase extends UseCase<UserPreferences?, NoParams> {
  final UserPreferencesRepository _repo;

  GetUserPreferencesUseCase(this._repo);

  @override
  FutureEither<UserPreferences?> call(NoParams params) =>
      _repo.getPreferences();
}
