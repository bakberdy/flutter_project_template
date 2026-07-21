import 'package:core/shared/entities/app_device_info.dart';
import 'package:core/shared/entities/app_info.dart';
import 'package:core/shared/entities/failure.dart';
import 'package:core/shared/services/device_info_service.dart';
import 'package:core/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class DeviceInfoRepository {
  FutureEither<AppDeviceInfo> getDeviceInfo();

  FutureEither<AppInfo> getAppInfo();
}

@LazySingleton(as: DeviceInfoRepository)
class DeviceInfoRepositoryImpl implements DeviceInfoRepository {
  DeviceInfoRepositoryImpl(this._deviceInfoService);
  final DeviceInfoService _deviceInfoService;

  @override
  FutureEither<AppDeviceInfo> getDeviceInfo() async {
    try {
      final deviceInfo = await _deviceInfoService.getDeviceInfo();
      return Right(deviceInfo);
    } on Exception catch (e) {
      return Left(
        Failure(
          message: 'Failed to get device info: $e',
          source: 'DeviceInfoRepository.getDeviceInfo',
        ),
      );
    }
  }

  @override
  FutureEither<AppInfo> getAppInfo() async {
    try {
      final appInfo = await _deviceInfoService.getAppInfo();
      return Right(appInfo);
    } on Exception catch (e) {
      return Left(
        Failure(
          message: 'Failed to get app info: $e',
          source: 'DeviceInfoRepository.getAppInfo',
        ),
      );
    }
  }
}
