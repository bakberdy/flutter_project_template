import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('writes recorded errors as named crash logs', () async {
    final talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
    final provider = TalkerCrashProvider(talker);
    final error = StateError('failed');

    await provider.recordError(error, StackTrace.current, reason: 'zone');

    final log = talker.history.single;
    expect(log.title, 'Crash');
    expect(log.logLevel, LogLevel.error);
    expect(log.exception, same(error));
    expect(log.message, contains('zone'));
  });
}
