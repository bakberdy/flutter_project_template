import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  test('serializes user fields using the API snake case contract', () {
    final json = <String, dynamic>{
      'id': 'user-1',
      'email': 'user@example.com',
      'role': 'user',
      'status': 'active',
      'is_verified': true,
      'created_at': '2026-07-15T10:30:00.000Z',
      'is_user_data_uploaded': false,
    };

    final user = UserModel.fromJson(json);

    expect(user.isVerified, isTrue);
    expect(user.isUserDataUploaded, isFalse);
    expect(user.toJson(), json);
  });
}
