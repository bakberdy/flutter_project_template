import 'package:admin_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/usecases/set_user_notifications_use_case.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _AnalyticsProviderFake analyticsProvider;

  setUp(() {
    analyticsProvider = _AnalyticsProviderFake();
    Analytics.initialize([analyticsProvider]);
  });

  tearDown(() => Analytics.initialize([]));

  test('tracks a successful notification preference update', () async {
    final useCase = SetUserNotificationsUseCase(
      _UserPreferencesRepositoryFake(),
    );

    await useCase(
      const SetUserNotificationsUseCaseParams(pushNotificationsEnabled: false),
    );

    final event = analyticsProvider.events.single;
    expect(event.name, 'set_user_notifications_usecase_success');
    expect(event.properties?['push_notifications_enabled'], isFalse);
  });
}

class _AnalyticsProviderFake implements AnalyticsProvider {
  final List<AnalyticsEvent> events = [];

  @override
  Future<void> track(AnalyticsEvent event) async => events.add(event);

  @override
  Future<void> setUserId(String? userId) async {}

  @override
  Future<void> setUserProperty(Map<String, dynamic> properties) async {}
}

class _UserPreferencesRepositoryFake implements UserPreferencesRepository {
  @override
  FutureEither<UserPreferences> setNotifications({
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? marketingNotificationsEnabled,
  }) async => Right(
    UserPreferences(
      userId: 'user',
      language: UserLanguage.en,
      theme: UserTheme.system,
      pushNotificationsEnabled: pushNotificationsEnabled ?? true,
      emailNotificationsEnabled: emailNotificationsEnabled ?? true,
      marketingNotificationsEnabled: marketingNotificationsEnabled ?? false,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
  );

  @override
  FutureEither<UserLanguage?> getLanguage() => throw UnimplementedError();

  @override
  FutureEither<UserPreferences?> getPreferences() => throw UnimplementedError();

  @override
  FutureEither<UserTheme?> getTheme() => throw UnimplementedError();

  @override
  FutureEither<void> setLanguage(UserLanguage language) =>
      throw UnimplementedError();

  @override
  FutureEither<void> setTheme(UserTheme theme) => throw UnimplementedError();
}
