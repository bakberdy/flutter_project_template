import 'package:core/domain/failures/failure.dart';

final class GetAppInfoFailure extends Failure {
  const GetAppInfoFailure({
    required super.source,
    super.details,
  });
}
