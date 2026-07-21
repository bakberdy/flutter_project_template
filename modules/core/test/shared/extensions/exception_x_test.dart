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

      expect(failure, isA<RequestFailedFailure>());
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
            'details': {
              'status_code': 401,
              'type': 'inline',
              'field_errors': [
                {'field_name': 'email', 'message': 'Email is invalid'},
              ],
            },
          },
          statusCode: 401,
        ),
      );

      final failure = await exception.toFailure(source: 'auth.login');

      expect(failure, isA<BackendFailure>());
      expect((failure as BackendFailure).message, 'Invalid credentials');
      expect(failure.details?.statusCode, 401);
      expect(failure.details?.type, FailureType.inline);
      expect(
        failure.details?.fieldErrors,
        const [
          BackendFieldFailure(
            fieldName: 'email',
            message: 'Email is invalid',
          ),
        ],
      );
    });

    test('maps refused backend connections to service unavailable', () async {
      const exception = ApiException(
        type: ApiExceptionType.connectionError,
        error: 'SocketException: Connection refused',
      );

      final failure = await exception.toFailure(source: 'auth.login');

      expect(failure, isA<ServiceUnavailableFailure>());
      expect(failure.details?.statusCode, 503);
      expect(failure.details?.type, FailureType.snackbar);
    });

    test('keeps internet connection error for host lookup failures', () async {
      const exception = ApiException(
        type: ApiExceptionType.connectionError,
        error: 'SocketException: Failed host lookup',
      );

      final failure = await exception.toFailure(source: 'auth.login');

      expect(failure, isA<NoConnectionFailure>());
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

      expect(failure, isA<ServiceUnavailableFailure>());
      expect(failure.details?.statusCode, 503);
      expect(failure.details?.type, FailureType.snackbar);
    });

    test('maps format exceptions to invalid response failures', () async {
      const exception = FormatException('Invalid response');

      final failure = await exception.toFailure(source: 'auth.login');

      expect(failure, isA<InvalidResponseFailure>());
      expect(failure.source, 'auth.login');
    });

    test('maps unclassified exceptions to unknown failures', () async {
      final failure = await Exception(
        'Unexpected error',
      ).toFailure(source: 'auth.login');

      expect(failure, isA<UnknownFailure>());
      expect(failure.source, 'auth.login');
    });

    test('creates silent typed cancellation failures', () {
      final failure = Failure.requestCancelled('auth.login');

      expect(failure, isA<RequestCancelledFailure>());
      expect(failure.source, 'auth.login');
      expect(failure.details?.type, FailureType.silent);
    });
  });
}
