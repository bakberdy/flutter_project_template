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
      baseUrl: _readString(json, 'baseUrl', fallback: _baseUrl),
      environment: _readString(
        json,
        'environment',
        fallback: _environmentFromDefine,
      ),
      enableLogging: _readBool(json, 'enableLogging', fallback: true),
      enableAnalytics: _readBool(json, 'enableAnalytics', fallback: true),
      enableCrashlytics: _readBool(json, 'enableCrashlytics', fallback: true),
      connectTimeout: _readDuration(
        json,
        'connectTimeoutSeconds',
        fallback: const Duration(seconds: 30),
      ),
      receiveTimeout: _readDuration(
        json,
        'receiveTimeoutSeconds',
        fallback: const Duration(seconds: 30),
      ),
      sendTimeout: _readDuration(
        json,
        'sendTimeoutSeconds',
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
    Map<String, dynamic> json,
    String key, {
    required String fallback,
  }) {
    final value = json[key];
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return fallback;
  }

  static bool _readBool(
    Map<String, dynamic> json,
    String key, {
    required bool fallback,
  }) {
    final value = json[key];
    if (value is bool) {
      return value;
    }
    return fallback;
  }

  static Duration _readDuration(
    Map<String, dynamic> json,
    String key, {
    required Duration fallback,
  }) {
    final value = json[key];
    if (value is int && value > 0) {
      return Duration(seconds: value);
    }
    return fallback;
  }
}
