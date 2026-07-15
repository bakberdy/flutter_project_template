import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExceptionX.toFailure', () {
    test('maps non-json bad responses without throwing', () async {
      const exception = ApiException(
        type: ApiExceptionType.badResponse,
        response: ApiResponse<String>(
          data: '<html>301 Moved Permanently</html>',
          statusCode: 301,
          statusMessage: 'Moved Permanently',
        ),
      );

      final failure = await exception.toFailure(source: 'auth.login');

      expect(failure.message, isNull);
      expect(failure.reason, FailureReason.requestFailed);
      expect(failure.source, 'auth.login');
      expect(failure.details?.statusCode, 301);
      expect(failure.details?.type, FailureType.snackbar);
    });

    test('maps backend json error responses', () async {
      const exception = ApiException(
        type: ApiExceptionType.badResponse,
        response: ApiResponse<Map<String, dynamic>>(
          data: {
            'message': 'Invalid credentials',
            'code': 401,
            'details': {'status_code': 401, 'type': 'inline'},
          },
          statusCode: 401,
        ),
      );

      final failure = await exception.toFailure(source: 'auth.login');

      expect(failure.message, 'Invalid credentials');
      expect(failure.reason, FailureReason.backend);
      expect(failure.details?.statusCode, 401);
      expect(failure.details?.type, FailureType.inline);
    });

    test('maps refused backend connections to service unavailable', () async {
      const exception = ApiException(
        type: ApiExceptionType.connectionError,
        error: 'SocketException: Connection refused',
      );

      final failure = await exception.toFailure(source: 'auth.login');

      expect(failure.message, isNull);
      expect(failure.reason, FailureReason.serviceUnavailable);
      expect(failure.details?.statusCode, 503);
      expect(failure.details?.type, FailureType.snackbar);
    });

    test('keeps internet connection error for host lookup failures', () async {
      const exception = ApiException(
        type: ApiExceptionType.connectionError,
        error: 'SocketException: Failed host lookup',
      );

      final failure = await exception.toFailure(source: 'auth.login');

      expect(failure.message, isNull);
      expect(failure.reason, FailureReason.noConnection);
      expect(failure.details?.statusCode, 0);
      expect(failure.details?.type, FailureType.snackbar);
    });

    test('maps http 503 responses to service unavailable', () async {
      const exception = ApiException(
        type: ApiExceptionType.badResponse,
        response: ApiResponse<String>(
          data: '<html>503 Service Unavailable</html>',
          statusCode: 503,
          statusMessage: 'Service Unavailable',
        ),
      );

      final failure = await exception.toFailure(source: 'auth.login');

      expect(failure.message, isNull);
      expect(failure.reason, FailureReason.serviceUnavailable);
      expect(failure.details?.statusCode, 503);
      expect(failure.details?.type, FailureType.snackbar);
    });
  });
}
