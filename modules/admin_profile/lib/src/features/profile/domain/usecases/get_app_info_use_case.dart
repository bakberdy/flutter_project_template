import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAppInfoUseCase extends UseCase<AppInfo, NoParams> {
  final DeviceInfoService _deviceInfoService;

  GetAppInfoUseCase(this._deviceInfoService);

  @override
  FutureEither<AppInfo> call(NoParams params) async {
    final appInfo = await _deviceInfoService.getAppInfo();
    return Right(appInfo);
  }
}
