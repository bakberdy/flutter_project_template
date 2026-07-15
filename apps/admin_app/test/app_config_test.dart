import 'package:admin_app/src/common/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConfig', () {
    test('throws when required dart defines are missing', () async {
      await expectLater(
        AppConfig.load(),
        throwsA(
          isA<AppConfigException>().having(
            (error) => error.message,
            'message',
            contains('Missing required dart define: API_URL'),
          ),
        ),
      );
    });
  });
}
