import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('writes analytics events as named info logs', () async {
    final talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
    final provider = TalkerAnalyticsProvider(talker);

    await provider.track(
      const AnalyticsEvent(name: 'opened', properties: {'source': 'test'}),
    );

    final log = talker.history.single;
    expect(log.title, 'Analytics');
    expect(log.logLevel, LogLevel.info);
    expect(log.message, contains('opened'));
    expect(log.message, contains('source'));
  });
}
