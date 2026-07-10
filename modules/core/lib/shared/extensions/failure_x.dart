import 'package:core/shared/entities/failure.dart';

extension FailureX on Failure {
  String get defaultMessage {
    return switch (details?.statusCode) {
      0 => 'No internet connection',
      _ => 'Something went wrong. Try again.',
    };
  }
}
