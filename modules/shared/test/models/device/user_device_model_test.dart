import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  test('serializes request-only push token fields', () {
    const device = UserDevice(
      deviceId: 'device-id',
      os: 'ios',
      osVersion: '18',
      model: 'iPhone',
      appVersion: '1.0.0',
      pushProvider: 'apns',
      pushToken: 'push-token',
    );

    expect(UserDeviceModel.fromEntity(device).toJson(), {
      'device_id': 'device-id',
      'os': 'ios',
      'os_version': '18',
      'model': 'iPhone',
      'app_version': '1.0.0',
      'push_provider': 'apns',
      'push_token': 'push-token',
    });
  });

  test('deserializes response-only notification token state', () {
    final model = UserDeviceModel.fromJson(const {
      'id': 'device-record-id',
      'client_device_id': 'device-id',
      'os': 'ios',
      'os_version': '18',
      'model': 'iPhone',
      'app_version': '1.0.0',
      'push_provider': 'apns',
      'has_notification_token': true,
    });

    expect(model.deviceId, isNull);
    expect(model.pushToken, isNull);
    expect(model.clientDeviceId, 'device-id');
    expect(model.hasNotificationToken, isTrue);
  });
}
