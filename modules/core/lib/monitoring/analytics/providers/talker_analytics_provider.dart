import 'package:talker/talker.dart';

import '../analytics.dart';
import '../analytics_events.dart';

/// Talker-backed analytics provider for development/debugging.
class TalkerAnalyticsProvider implements AnalyticsProvider {
  const TalkerAnalyticsProvider(this._talker);

  final Talker _talker;

  @override
  Future<void> track(AnalyticsEvent event) async {
    _talker.info('Analytics event tracked: ${event.name}');
    if (event.properties != null) {
      _talker.debug('Analytics properties: ${event.properties}');
    }
  }

  @override
  Future<void> setUserId(String? userId) async {
    _talker.info('Analytics user ID set: $userId');
  }

  @override
  Future<void> setUserProperty(Map<String, dynamic> properties) async {
    _talker.info('Analytics user property set: $properties');
  }
}
