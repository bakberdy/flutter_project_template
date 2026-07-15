import 'dart:async';
import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _RecordingCrashProvider provider;
  late FlutterExceptionHandler? previousFlutterHandler;
  late ErrorCallback? previousPlatformHandler;

  setUp(() {
    provider = _RecordingCrashProvider();
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

      expect(
        provider.reasons,
        containsAll([
          UnhandledErrorSource.flutterFramework.reason,
          UnhandledErrorSource.platformDispatcher.reason,
          UnhandledErrorSource.zone.reason,
        ]),
      );
    },
  );
}

class _RecordingCrashProvider implements CrashlyticsProvider {
  final List<String?> reasons = [];

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    Map<String, dynamic>? data,
  }) async {
    reasons.add(reason);
  }

  @override
  Future<void> clearUserId() async {}

  @override
  Future<void> log(String message) async {}

  @override
  Future<void> setUserId(String userId) async {}
}
