import 'package:core/monitoring/crashlytics/crashlytics_provider.dart';
import 'package:talker/talker.dart';

class TalkerCrashProvider implements CrashlyticsProvider {
  TalkerCrashProvider(this._talker);

  final Talker _talker;
  String? _userId;

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    Map<String, dynamic>? data,
  }) async {
    final parts = <String>[];

    if (reason != null) {
      parts.add('Reason: $reason');
    }

    if (_userId != null) {
      parts.add('User: $_userId');
    }

    if (data != null && data.isNotEmpty) {
      parts.add('Data: $data');
    }

    final message = parts.isEmpty
        ? 'Crash recorded: $exception'
        : 'Crash recorded: $exception (${parts.join(', ')})';

    _talker.logCustom(
      TalkerLog(
        message,
        title: 'Crash',
        logLevel: LogLevel.error,
        exception: exception,
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  Future<void> log(String message) async {
    _logInfo(message);
  }

  @override
  Future<void> setUserId(String userId) async {
    _userId = userId;
    _logInfo('User set: $userId');
  }

  @override
  Future<void> clearUserId() async {
    _userId = null;
    _logInfo('User cleared');
  }

  void _logInfo(String message) {
    _talker.logCustom(
      TalkerLog(message, title: 'Crash', logLevel: LogLevel.info),
    );
  }
}
