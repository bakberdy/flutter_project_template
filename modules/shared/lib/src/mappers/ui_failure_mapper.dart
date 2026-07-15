import 'package:core/core.dart';

abstract final class UiFailureMapper {
  static String message(Failure failure) {
    return failure.message ??
        switch (failure.details?.statusCode) {
          0 => 'No internet connection',
          _ => 'Something went wrong. Try again.',
        };
  }
}
