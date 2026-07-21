import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const failures = <FieldFailure>[
    BackendFieldFailure(fieldName: 'email', message: 'Invalid email'),
    BackendFieldFailure(fieldName: 'phone_number', message: 'Invalid phone'),
  ];

  test('returns a backend message for one field', () {
    expect(failures.backendMessageForField('email'), 'Invalid email');
  });

  test('returns a backend message for any matching field', () {
    expect(
      failures.backendMessageForAnyField(const {'full_name', 'phone_number'}),
      'Invalid phone',
    );
  });

  test('returns null when no backend field matches', () {
    expect(failures.backendMessageForField('code'), isNull);
  });
}
