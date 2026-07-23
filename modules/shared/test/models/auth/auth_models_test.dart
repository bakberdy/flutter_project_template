import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  test('serializes login request with nested snake case device fields', () {
    const entity = AuthLoginRequest(
      email: 'user@example.com',
      device: UserDevice(
        deviceId: 'device-id',
        os: 'ios',
        osVersion: '18',
        model: 'iPhone',
        appVersion: '1.0.0',
        pushProvider: 'apns',
        pushToken: 'push-token',
      ),
    );

    expect(AuthLoginRequestModel.fromEntity(entity).toJson(), {
      'email': 'user@example.com',
      'device': {
        'device_id': 'device-id',
        'os': 'ios',
        'os_version': '18',
        'model': 'iPhone',
        'app_version': '1.0.0',
        'push_provider': 'apns',
        'push_token': 'push-token',
      },
    });
  });

  test('serializes verify request with snake case fields', () {
    const entity = AuthVerifyRequest(
      loginRequestId: 'request-id',
      email: 'user@example.com',
      code: '123456',
    );

    expect(AuthVerifyRequestModel.fromEntity(entity).toJson(), {
      'login_request_id': 'request-id',
      'email': 'user@example.com',
      'code': '123456',
    });
  });

  test('deserializes and serializes auth responses', () {
    final loginJson = <String, dynamic>{
      'message': 'OTP sent',
      'login_request_id': 'request-id',
      'otp_expires_in': 300,
    };
    final verifyJson = <String, dynamic>{
      'access_token': 'access-token',
      'refresh_token': 'refresh-token',
    };

    expect(AuthLoginResponseModel.fromJson(loginJson).toJson(), loginJson);
    expect(AuthVerifyResponseModel.fromJson(verifyJson).toJson(), verifyJson);
  });
}
