import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

abstract class UserPreferencesLocalDataSource {
  Future<void> setUserPreference({required String key, required String value});
  Future<String?> getUserPreference({required String key});
}

@Singleton(as: UserPreferencesLocalDataSource)
class UserPreferencesLocalDataSourceImpl
    implements UserPreferencesLocalDataSource {
  final LocalStorage localStorage;

  UserPreferencesLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> setUserPreference({
    required String key,
    required String value,
  }) => localStorage.write(key: key, value: value);

  @override
  Future<String?> getUserPreference({required String key}) =>
      localStorage.read(key: key);
}
