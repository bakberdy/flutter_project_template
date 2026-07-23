import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  final json = <String, dynamic>{
    'id': 'session-1',
    'user_id': 'user-1',
    'refresh_token_hash': 'refresh-token-hash',
    'created_at': '2026-07-23T08:00:00.000Z',
    'expires_at': '2026-08-23T08:00:00.000Z',
    'last_active': '2026-07-23T09:00:00.000Z',
    'revoked_at': null,
    'is_revoked': false,
    'device': <String, dynamic>{
      'id': 'device-1',
      'client_device_id': 'client-device-1',
      'os': 'iOS',
      'os_version': '26.0',
      'model': 'iPhone',
      'app_version': '1.0.0',
      'push_provider': 'apns',
      'has_notification_token': true,
    },
  };

  test('serializes session fields using the API snake case contract', () {
    final session = UserSessionModel.fromJson(json);

    expect(session.device.clientDeviceId, 'client-device-1');
    expect(session.lastActive, DateTime.utc(2026, 7, 23, 9));
    expect(session.toJson(), json);
  });

  test('fromEntity converts the nested device to its model', () {
    final entity = UserSession(
      id: 'session-1',
      userId: 'user-1',
      refreshTokenHash: 'refresh-token-hash',
      createdAt: DateTime.utc(2026, 7, 23, 8),
      expiresAt: DateTime.utc(2026, 8, 23, 8),
      lastActive: DateTime.utc(2026, 7, 23, 9),
      isRevoked: false,
      device: const UserSessionDevice(
        id: 'device-1',
        clientDeviceId: 'client-device-1',
        os: 'iOS',
        osVersion: '26.0',
        model: 'iPhone',
        appVersion: '1.0.0',
        pushProvider: 'apns',
        hasNotificationToken: true,
      ),
    );

    final model = UserSessionModel.fromEntity(entity);

    expect(model.device, isA<UserSessionDeviceModel>());
    expect(model.toJson(), json);
  });
}
