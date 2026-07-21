import 'package:core/domain/failures/device_info_failure.dart';
import 'package:core/shared/entities/app_device_info.dart';
import 'package:core/shared/entities/app_info.dart';
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
    } on Exception {
      return const Left(
        GetDeviceInfoFailure(
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
    } on Exception {
      return const Left(
        GetAppInfoFailure(
          source: 'DeviceInfoRepository.getAppInfo',
        ),
      );
    }
  }
}
