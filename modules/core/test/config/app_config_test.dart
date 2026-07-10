import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConfig', () {
    test('reads dart-define-from-file style keys', () {
      final config = AppConfig.fromJson(const {
        'API_URL': 'https://api.example.test',
        'ENVIRONMENT': 'development',
        'ENABLE_LOGGING': false,
        'ENABLE_ANALYTICS': true,
        'ENABLE_CRASHLYTICS': true,
        'CONNECT_TIMEOUT_SECONDS': 10,
        'RECEIVE_TIMEOUT_SECONDS': 20,
        'SEND_TIMEOUT_SECONDS': 30,
      });

      expect(config.baseUrl, 'https://api.example.test');
      expect(config.environment, 'development');
      expect(config.enableLogging, isFalse);
      expect(config.enableAnalytics, isTrue);
      expect(config.enableCrashlytics, isTrue);
      expect(config.connectTimeout, const Duration(seconds: 10));
      expect(config.receiveTimeout, const Duration(seconds: 20));
      expect(config.sendTimeout, const Duration(seconds: 30));
    });

    test('keeps existing asset config key compatibility', () {
      final config = AppConfig.fromJson(const {
        'baseUrl': 'https://asset.example.test',
        'environment': 'production',
        'enableLogging': true,
        'enableAnalytics': false,
        'enableCrashlytics': false,
        'connectTimeoutSeconds': 11,
        'receiveTimeoutSeconds': 21,
        'sendTimeoutSeconds': 31,
      });

      expect(config.baseUrl, 'https://asset.example.test');
      expect(config.environment, 'production');
      expect(config.enableLogging, isTrue);
      expect(config.enableAnalytics, isFalse);
      expect(config.enableCrashlytics, isFalse);
      expect(config.connectTimeout, const Duration(seconds: 11));
      expect(config.receiveTimeout, const Duration(seconds: 21));
      expect(config.sendTimeout, const Duration(seconds: 31));
    });
  });
}
