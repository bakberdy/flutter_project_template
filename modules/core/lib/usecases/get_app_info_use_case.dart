import 'dart:async';

import 'package:core/monitoring/analytics/analytics.dart';
import 'package:core/monitoring/analytics/analytics_events.dart';
import 'package:core/monitoring/analytics/events/get_app_info_use_case_event.dart';
import 'package:core/shared/entities/app_info.dart';
import 'package:core/shared/repositories/device_info_repository.dart';
import 'package:core/usecases/use_case.dart';
import 'package:core/utils/typedef.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAppInfoUseCase extends UseCase<AppInfo, NoParams> {

  GetAppInfoUseCase(this._deviceInfoRepository);
  final DeviceInfoRepository _deviceInfoRepository;

  @override
  FutureEither<AppInfo> call(NoParams params) async {
    final result = await _deviceInfoRepository.getAppInfo();

    result.fold(
      (failure) => unawaited(
        Analytics.track(
          GetAppInfoUseCaseEvent.failure(
            properties: {
              AnalyticsPropertyKeys.failureMessage: failure.message,
              AnalyticsPropertyKeys.failureType: failure.details?.type.name,
              AnalyticsPropertyKeys.failureSource: failure.source,
            },
          ),
        ),
      ),
      (appInfo) => unawaited(
        Analytics.track(
          GetAppInfoUseCaseEvent.success(
            properties: {
              AnalyticsPropertyKeys.appVersion: appInfo.version,
              'build_number': appInfo.buildNumber,
            },
          ),
        ),
      ),
    );

    return result;
  }
}
