import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  group('UiFailureMapper', () {
    test('prefers the failure message', () {
      const failure = Failure(
        message: 'Request failed',
        source: 'test',
        details: FailureDetails(statusCode: 500),
      );

      expect(UiFailureMapper.message(failure), 'Request failed');
    });

    test('maps connection failures to the existing fallback message', () {
      const failure = Failure(
        source: 'test',
        details: FailureDetails(statusCode: 0),
      );

      expect(UiFailureMapper.message(failure), 'No internet connection');
    });

    test('maps other failures to the existing fallback message', () {
      const failure = Failure(
        source: 'test',
        details: FailureDetails(statusCode: 500),
      );

      expect(
        UiFailureMapper.message(failure),
        'Something went wrong. Try again.',
      );
    });
  });
}
