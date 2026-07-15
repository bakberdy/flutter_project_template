import 'app_info.dart';

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
