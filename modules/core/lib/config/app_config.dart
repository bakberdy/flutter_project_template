import 'dart:convert';

import 'package:core/config/core_app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppConfig implements CoreAppConfig {
  static const String defaultAssetPath = 'config/app_config.json';
  static const String _baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'not-provided',
  );
  static const String _environmentFromDefine = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'not-provided',
  );
  static const bool _hasDartDefineConfig =
      _baseUrl != 'not-provided' || _environmentFromDefine != 'not-provided';

  @override
  final String environment;
  final bool enableLogging;
  final bool enableAnalytics;
  final bool enableCrashlytics;
  @override
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;

  static AppConfig instance = AppConfig._internal(
    baseUrl: _baseUrl,
    environment: _environmentFromDefine,
    enableLogging: true,
    enableAnalytics: true,
    enableCrashlytics: true,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  );

  static Future<void> load({String assetPath = defaultAssetPath}) async {
    if (_hasDartDefineConfig) {
      instance = _fromEnvironment();
      return;
    }

    try {
      final source = await rootBundle.loadString(assetPath);
      final json = jsonDecode(source);
      if (json is! Map<String, dynamic>) {
        throw const FormatException('App config root must be a JSON object');
      }
      instance = AppConfig.fromJson(json);
    } on FlutterError {
      instance = _fromEnvironment();
    }
  }

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig._internal(
      baseUrl: _readString(
        json,
        keys: const ['baseUrl', 'API_URL'],
        fallback: _baseUrl,
      ),
      environment: _readString(
        json,
        keys: const ['environment', 'ENVIRONMENT'],
        fallback: _environmentFromDefine,
      ),
      enableLogging: _readBool(
        json,
        keys: const ['enableLogging', 'ENABLE_LOGGING'],
        fallback: true,
      ),
      enableAnalytics: _readBool(
        json,
        keys: const ['enableAnalytics', 'ENABLE_ANALYTICS'],
        fallback: true,
      ),
      enableCrashlytics: _readBool(
        json,
        keys: const ['enableCrashlytics', 'ENABLE_CRASHLYTICS'],
        fallback: true,
      ),
      connectTimeout: _readDuration(
        json,
        keys: const ['connectTimeoutSeconds', 'CONNECT_TIMEOUT_SECONDS'],
        fallback: const Duration(seconds: 30),
      ),
      receiveTimeout: _readDuration(
        json,
        keys: const ['receiveTimeoutSeconds', 'RECEIVE_TIMEOUT_SECONDS'],
        fallback: const Duration(seconds: 30),
      ),
      sendTimeout: _readDuration(
        json,
        keys: const ['sendTimeoutSeconds', 'SEND_TIMEOUT_SECONDS'],
        fallback: const Duration(seconds: 30),
      ),
    );
  }

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
      baseUrl: _baseUrl,
      environment: _environmentFromDefine,
      enableLogging: true,
      enableAnalytics: true,
      enableCrashlytics: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
  }

  static String _readString(
    Map<String, dynamic> json, {
    required List<String> keys,
    required String fallback,
  }) {
    for (final key in keys) {
      final value = json[key];
      if (value is String && value.isNotEmpty) {
        return value;
      }
    }
    return fallback;
  }

  static bool _readBool(
    Map<String, dynamic> json, {
    required List<String> keys,
    required bool fallback,
  }) {
    for (final key in keys) {
      final value = json[key];
      if (value is bool) {
        return value;
      }
    }
    return fallback;
  }

  static Duration _readDuration(
    Map<String, dynamic> json, {
    required List<String> keys,
    required Duration fallback,
  }) {
    for (final key in keys) {
      final value = json[key];
      if (value is int && value > 0) {
        return Duration(seconds: value);
      }
    }
    return fallback;
  }
}
