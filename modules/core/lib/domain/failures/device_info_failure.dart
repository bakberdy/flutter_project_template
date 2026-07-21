import 'package:core/domain/failures/failure.dart';

final class GetAppInfoFailure extends Failure {
  const GetAppInfoFailure({
    required super.source,
    super.details,
  });
}

final class GetDeviceInfoFailure extends Failure {
  const GetDeviceInfoFailure({
    required super.source,
    super.details,
  });
}
