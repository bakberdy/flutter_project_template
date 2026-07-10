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

      expect(failure.message, 'Request failed');
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
      expect(failure.details?.statusCode, 401);
      expect(failure.details?.type, FailureType.inline);
    });
  });
}
