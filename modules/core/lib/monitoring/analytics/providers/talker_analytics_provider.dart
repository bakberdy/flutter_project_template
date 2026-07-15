import 'package:talker/talker.dart';

import '../analytics.dart';
import '../analytics_events.dart';

/// Talker-backed analytics provider.
class TalkerAnalyticsProvider implements AnalyticsProvider {
  const TalkerAnalyticsProvider(this._talker);

  final Talker _talker;

  @override
  Future<void> track(AnalyticsEvent event) async {
    final properties = event.properties;
    _log(
      properties == null
          ? 'Event tracked: ${event.name}'
          : 'Event tracked: ${event.name}; properties: $properties',
    );
  }

  @override
  Future<void> setUserId(String? userId) async {
    _log('User ID set: $userId');
  }

  @override
  Future<void> setUserProperty(Map<String, dynamic> properties) async {
    _log('User properties set: $properties');
  }

  void _log(String message) {
    _talker.logCustom(
      TalkerLog(message, title: 'Analytics', logLevel: LogLevel.info),
    );
  }
}
