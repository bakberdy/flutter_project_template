import 'package:admin_users/src/features/users/domain/usecases/admin_users_use_case_tracking.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late _MockAnalyticsProvider analyticsProvider;

  setUpAll(() {
    registerFallbackValue(const AnalyticsEvent(name: 'fallback'));
  });

  setUp(() {
    analyticsProvider = _MockAnalyticsProvider();
    when(() => analyticsProvider.track(any())).thenAnswer((_) async {});
    Analytics.initialize([analyticsProvider]);
  });

  tearDown(() => Analytics.initialize([]));

  test('tracks a successful admin users operation', () async {
    await trackAdminUsersUseCase(
      FutureEither<int>.value(const Right(1)),
      'get_users',
      properties: const {'has_search': true},
    );

    final event =
        verify(() => analyticsProvider.track(captureAny())).captured.single
            as AnalyticsEvent;
    expect(event.name, 'admin_users_get_users_usecase_success');
    expect(event.properties, const {'has_search': true});
  });

  test('tracks a failed admin users operation with failure details', () async {
    const failure = BackendFailure(
      message: 'Request failed',
      source: 'UsersRepository.getUsers',
    );

    await trackAdminUsersUseCase(
      FutureEither<int>.value(const Left(failure)),
      'get_users',
      properties: const {'has_search': false},
    );

    final event =
        verify(() => analyticsProvider.track(captureAny())).captured.single
            as AnalyticsEvent;
    expect(event.name, 'admin_users_get_users_usecase_failure');
    expect(event.properties?['has_search'], isFalse);
    expect(
      event.properties?[AnalyticsPropertyKeys.failureMessage],
      failure.message,
    );
    expect(
      event.properties?[AnalyticsPropertyKeys.failureSource],
      failure.source,
    );
  });
}

class _MockAnalyticsProvider extends Mock implements AnalyticsProvider {}
