import 'package:client_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:client_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:client_preferences/src/features/user_preferences/domain/usecases/set_user_notifications_use_case.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late _MockAnalyticsProvider analyticsProvider;
  late _MockUserPreferencesRepository repository;

  setUpAll(() {
    registerFallbackValue(const AnalyticsEvent(name: 'fallback'));
  });

  setUp(() {
    analyticsProvider = _MockAnalyticsProvider();
    repository = _MockUserPreferencesRepository();
    when(() => analyticsProvider.track(any())).thenAnswer((_) async {});
    when(
      () => repository.setNotifications(
        pushNotificationsEnabled: false,
        emailNotificationsEnabled: null,
        marketingNotificationsEnabled: null,
      ),
    ).thenAnswer((_) async => Right(_preferences));
    Analytics.initialize([analyticsProvider]);
  });

  tearDown(() => Analytics.initialize([]));

  test('tracks a successful notification preference update', () async {
    final useCase = SetUserNotificationsUseCase(repository);

    await useCase(
      const SetUserNotificationsUseCaseParams(pushNotificationsEnabled: false),
    );

    final event =
        verify(() => analyticsProvider.track(captureAny())).captured.single
            as AnalyticsEvent;
    expect(event.name, 'set_user_notifications_usecase_success');
    expect(event.properties?['push_notifications_enabled'], isFalse);
  });
}

final _preferences = UserPreferences(
  userId: 'user',
  language: UserLanguage.en,
  theme: UserTheme.system,
  pushNotificationsEnabled: false,
  emailNotificationsEnabled: true,
  marketingNotificationsEnabled: false,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

class _MockAnalyticsProvider extends Mock implements AnalyticsProvider {}

class _MockUserPreferencesRepository extends Mock
    implements UserPreferencesRepository {}
