import 'package:core/domain/failures/failure.dart';

final class GetDeviceInfoFailure extends Failure {
  const GetDeviceInfoFailure({
    required super.source,
    super.details,
  });
}
