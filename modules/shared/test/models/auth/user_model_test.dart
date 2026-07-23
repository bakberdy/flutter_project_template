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

  test('serializes a nested user profile using generated snake case keys', () {
    final json = <String, dynamic>{
      'user_id': 'user-1',
      'full_name': 'Example User',
      'phone_number': {
        'country_code': 'KZ',
        'dial_code': '+7',
        'number': '7001234567',
      },
      'avatar_url': 'https://example.com/avatar.png',
      'created_at': '2026-07-15T10:30:00.000Z',
      'updated_at': '2026-07-16T10:30:00.000Z',
      'completed_at': '2026-07-16T11:30:00.000Z',
    };

    final profile = UserProfileModel.fromJson(json);

    expect(profile.phoneNumber, isA<UserPhoneNumberModel>());
    expect(profile.phoneNumber?.countryCode, 'KZ');
    expect(profile.toJson(), json);
  });

  test('accepts a user profile phone number without a country code', () {
    final profile = UserProfileModel.fromJson(const {
      'user_id': 'user-1',
      'full_name': 'Example User',
      'phone_number': {'dial_code': '+7', 'number': '7001234567'},
      'created_at': '2026-07-15T10:30:00.000Z',
      'updated_at': '2026-07-16T10:30:00.000Z',
    });

    expect(profile.phoneNumber?.countryCode, isNull);
  });
}
