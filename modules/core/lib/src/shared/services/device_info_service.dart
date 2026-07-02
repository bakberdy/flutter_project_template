import 'package:core/src/shared/entities/app_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@singleton
class DeviceInfoService {
  DeviceInfoService() : _plugin = DeviceInfoPlugin();

  final DeviceInfoPlugin _plugin;

  Future<AppDeviceInfo> getDeviceInfo() async {
    final appInfo = await getAppInfo();

    try {
      if (kIsWeb) {
        return AppDeviceInfo(
          deviceId: 'web',
          os: 'web',
          osVersion: '',
          model: 'web',
          appInfo: appInfo,
        );
      }

      return switch (defaultTargetPlatform) {
        TargetPlatform.android => _androidInfo(appInfo),
        TargetPlatform.iOS => _iosInfo(appInfo),
        _ => AppDeviceInfo(
          deviceId: 'unsupported-${defaultTargetPlatform.name}',
          os: defaultTargetPlatform.name,
          osVersion: '',
          model: 'unsupported',
          appInfo: appInfo,
        ),
      };
    } on Exception {
      return AppDeviceInfo(
        deviceId: 'unknown-${defaultTargetPlatform.name}',
        os: defaultTargetPlatform.name,
        osVersion: '',
        model: 'unavailable',
        appInfo: appInfo,
      );
    }
  }

  Future<AppInfo> getAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return AppInfo(
        appName: packageInfo.appName,
        packageName: packageInfo.packageName,
        version: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
        buildSignature: packageInfo.buildSignature,
        installerStore: packageInfo.installerStore,
      );
    } on Exception {
      return const AppInfo(
        appName: '',
        packageName: '',
        version: '0.0.0',
        buildNumber: '0',
        buildSignature: '',
        installerStore: null,
      );
    }
  }

  Future<AppDeviceInfo> _androidInfo(AppInfo appInfo) async {
    final android = await _plugin.androidInfo;
    final deviceId = android.fingerprint.isNotEmpty
        ? android.fingerprint
        : '${android.brand}-${android.model}-${android.id}';

    return AppDeviceInfo(
      deviceId: deviceId,
      os: 'android',
      osVersion: android.version.release,
      model: '${android.brand} ${android.model}',
      appInfo: appInfo,
    );
  }

  Future<AppDeviceInfo> _iosInfo(AppInfo appInfo) async {
    final ios = await _plugin.iosInfo;

    return AppDeviceInfo(
      deviceId: ios.identifierForVendor ?? 'unknown-ios-device',
      os: 'ios',
      osVersion: ios.systemVersion,
      model: ios.modelName.isNotEmpty ? ios.modelName : ios.model,
      appInfo: appInfo,
    );
  }
}

class AppDeviceInfo {
  const AppDeviceInfo({
    required this.deviceId,
    required this.os,
    required this.osVersion,
    required this.model,
    required this.appInfo,
  });

  final String deviceId;
  final String os;
  final String osVersion;
  final String model;
  final AppInfo appInfo;

  String get appVersion => appInfo.version;
  String get appBuildNumber => appInfo.buildNumber;
}
