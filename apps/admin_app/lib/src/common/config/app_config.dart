import 'package:core/core.dart';

export 'package:core/core.dart' show AppConfigException;

class AppConfig implements CoreAppConfig {
  static const String _baseUrl = String.fromEnvironment('API_URL');
  static const String _environment = String.fromEnvironment('ENVIRONMENT');
  static const String _enableLogging = String.fromEnvironment('ENABLE_LOGGING');
  static const String _enableAnalytics = String.fromEnvironment(
    'ENABLE_ANALYTICS',
  );
  static const String _enableCrashlytics = String.fromEnvironment(
    'ENABLE_CRASHLYTICS',
  );
  static const String _connectTimeoutSeconds = String.fromEnvironment(
    'CONNECT_TIMEOUT_SECONDS',
  );
  static const String _receiveTimeoutSeconds = String.fromEnvironment(
    'RECEIVE_TIMEOUT_SECONDS',
  );
  static const String _sendTimeoutSeconds = String.fromEnvironment(
    'SEND_TIMEOUT_SECONDS',
  );

  @override
  final String environment;
  final bool enableLogging;
  final bool enableAnalytics;
  final bool enableCrashlytics;
  @override
  final String baseUrl;
  @override
  final Duration connectTimeout;
  @override
  final Duration receiveTimeout;
  @override
  final Duration sendTimeout;

  static AppConfig? _instance;

  static AppConfig get instance {
    final config = _instance;
    if (config == null) {
      throw StateError(
        'AppConfig.load() must be called before AppConfig.instance.',
      );
    }
    return config;
  }

  static Future<void> load() async => _instance = _fromEnvironment();

  AppConfig._internal({
    required this.baseUrl,
    required this.environment,
    required this.enableLogging,
    required this.enableAnalytics,
    required this.enableCrashlytics,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
  });

  static AppConfig _fromEnvironment() {
    return AppConfig._internal(
      baseUrl: _readRequiredString('API_URL', _baseUrl),
      environment: _readRequiredString('ENVIRONMENT', _environment),
      enableLogging: _readRequiredBool('ENABLE_LOGGING', _enableLogging),
      enableAnalytics: _readRequiredBool('ENABLE_ANALYTICS', _enableAnalytics),
      enableCrashlytics: _readRequiredBool(
        'ENABLE_CRASHLYTICS',
        _enableCrashlytics,
      ),
      connectTimeout: _readRequiredDuration(
        'CONNECT_TIMEOUT_SECONDS',
        _connectTimeoutSeconds,
      ),
      receiveTimeout: _readRequiredDuration(
        'RECEIVE_TIMEOUT_SECONDS',
        _receiveTimeoutSeconds,
      ),
      sendTimeout: _readRequiredDuration(
        'SEND_TIMEOUT_SECONDS',
        _sendTimeoutSeconds,
      ),
    );
  }

  static String _readRequiredString(String name, String value) {
    if (value.isEmpty) {
      throw AppConfigException.missing(name);
    }
    return value;
  }

  static bool _readRequiredBool(String name, String value) {
    final normalizedValue = _readRequiredString(name, value).toLowerCase();
    if (normalizedValue == 'true') {
      return true;
    }
    if (normalizedValue == 'false') {
      return false;
    }
    throw AppConfigException.invalid(name, value, 'true or false');
  }

  static Duration _readRequiredDuration(String name, String value) {
    final seconds = int.tryParse(_readRequiredString(name, value));
    if (seconds == null || seconds <= 0) {
      throw AppConfigException.invalid(name, value, 'a positive integer');
    }
    return Duration(seconds: seconds);
  }
}
