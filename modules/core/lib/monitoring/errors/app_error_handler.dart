import 'dart:async';

import 'package:core/monitoring/crashlytics/crashlytics.dart';
import 'package:core/monitoring/errors/unhandled_error_source.dart';
import 'package:flutter/foundation.dart';

abstract final class AppErrorHandler {
  static Future<void> run(Future<void> Function() bootstrap) async {
    final future = runZonedGuarded<Future<void>>(
      () async {
        FlutterError.onError = _handleFlutterError;
        PlatformDispatcher.instance.onError = _handlePlatformError;
        await bootstrap();
      },
      (error, stackTrace) => _handleUnhandledError(
        error,
        stackTrace,
        source: UnhandledErrorSource.zone,
      ),
    );

    await future;
  }

  static void _handleFlutterError(FlutterErrorDetails details) {
    FlutterError.presentError(details);
    _recordError(
      details.exception,
      details.stack ?? StackTrace.current,
      source: UnhandledErrorSource.flutterFramework,
      data: {
        'library': ?details.library,
        'context': ?details.context?.toDescription(),
      },
    );
  }

  static bool _handlePlatformError(Object error, StackTrace stackTrace) {
    _handleUnhandledError(
      error,
      stackTrace,
      source: UnhandledErrorSource.platformDispatcher,
    );
    return true;
  }

  static void _handleUnhandledError(
    Object error,
    StackTrace stackTrace, {
    required UnhandledErrorSource source,
  }) {
    FlutterError.dumpErrorToConsole(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'app error handler',
        context: ErrorDescription('Unhandled ${source.reason} error'),
      ),
    );
    _recordError(error, stackTrace, source: source);
  }

  static void _recordError(
    Object error,
    StackTrace stackTrace, {
    required UnhandledErrorSource source,
    Map<String, dynamic>? data,
  }) {
    unawaited(
      Crashlytics.recordError(
        error,
        stackTrace,
        reason: source.reason,
        data: data,
      ).catchError((Object reportingError, StackTrace reportingStack) {
        FlutterError.dumpErrorToConsole(
          FlutterErrorDetails(
            exception: reportingError,
            stack: reportingStack,
            library: 'app error handler',
            context: ErrorDescription('Failed to report an unhandled error'),
          ),
        );
      }),
    );
  }
}
