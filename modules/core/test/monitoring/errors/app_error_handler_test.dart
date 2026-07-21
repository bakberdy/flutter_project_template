import 'dart:async';
import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _MockCrashProvider provider;
  late FlutterExceptionHandler? previousFlutterHandler;
  late ErrorCallback? previousPlatformHandler;

  setUp(() {
    provider = _MockCrashProvider();
    when(
      () => provider.recordError(
        any<Object?>(),
        any(),
        reason: any(named: 'reason'),
        data: any(named: 'data'),
      ),
    ).thenAnswer((_) async {});
    Crashlytics.initialize([provider]);
    previousFlutterHandler = FlutterError.onError;
    previousPlatformHandler = PlatformDispatcher.instance.onError;
  });

  tearDown(() {
    FlutterError.onError = previousFlutterHandler;
    PlatformDispatcher.instance.onError = previousPlatformHandler;
    Crashlytics.initialize([]);
  });

  test(
    'records framework, platform, and zone errors with their source',
    () async {
      await AppErrorHandler.run(() async {
        FlutterError.onError!(
          FlutterErrorDetails(exception: StateError('framework')),
        );
        PlatformDispatcher.instance.onError!(
          StateError('platform'),
          StackTrace.current,
        );
        Zone.current.handleUncaughtError(
          StateError('zone'),
          StackTrace.current,
        );
        await Future<void>.delayed(Duration.zero);
      });

      final reasons = verify(
        () => provider.recordError(
          any<Object?>(),
          any(),
          reason: captureAny(named: 'reason'),
          data: any(named: 'data'),
        ),
      ).captured;
      expect(
        reasons,
        containsAll(UnhandledErrorSource.values.map((e) => e.reason)),
      );
    },
  );
}

class _MockCrashProvider extends Mock implements CrashlyticsProvider {}
