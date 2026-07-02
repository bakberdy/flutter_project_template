import 'package:flutter_test/flutter_test.dart';
import 'package:admin_users/src/features/users/data/models/admin_user_model/admin_user_model.dart';
import 'package:admin_users/src/features/users/data/models/admin_user_phone_number_model/admin_user_phone_number_model.dart';
import 'package:admin_users/src/features/users/data/models/admin_user_profile_model/admin_user_profile_model.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';

void main() {
  test('parses user payload with backend snake_case keys', () {
    final user = AdminUserModel.fromJson({
      'id': '11111111-1111-1111-1111-111111111111',
      'email': 'admin@example.com',
      'role': 'admin',
      'status': 'active',
      'is_verified': true,
      'created_at': '2026-06-21T10:00:00.000Z',
      'is_user_data_uploaded': false,
    });

    expect(user.id, '11111111-1111-1111-1111-111111111111');
    expect(user.email, 'admin@example.com');
    expect(user.role, AdminUserRole.admin);
    expect(user.status, AdminUserStatus.active);
    expect(user.isVerified, isTrue);
    expect(user.createdAt, DateTime.parse('2026-06-21T10:00:00.000Z'));
    expect(user.isUserDataUploaded, isFalse);
  });

  test('parses user profile payload with nested snake_case keys', () {
    final profile = AdminUserProfileModel.fromJson({
      'user_id': '11111111-1111-1111-1111-111111111111',
      'full_name': 'Admin User',
      'phone_number': {
        'country_code': 'KZ',
        'dial_code': '+7',
        'number': '7001234567',
      },
      'avatar_url': 'https://example.com/avatar.png',
      'created_at': '2026-06-21T10:00:00.000Z',
      'updated_at': '2026-06-21T11:00:00.000Z',
      'completed_at': '2026-06-21T12:00:00.000Z',
    });

    expect(profile.userId, '11111111-1111-1111-1111-111111111111');
    expect(profile.fullName, 'Admin User');
    expect(profile.phoneNumber, isNotNull);
    expect(profile.phoneNumber, isA<AdminUserPhoneNumberModel>());
    expect(profile.avatarUrl, 'https://example.com/avatar.png');
    expect(profile.createdAt, DateTime.parse('2026-06-21T10:00:00.000Z'));
    expect(profile.updatedAt, DateTime.parse('2026-06-21T11:00:00.000Z'));
    expect(profile.completedAt, DateTime.parse('2026-06-21T12:00:00.000Z'));
  });
}
