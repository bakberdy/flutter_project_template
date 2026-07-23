import 'package:client_auth/src/features/auth/data/models/auth_login_request_model/auth_login_request_model.dart';
import 'package:client_auth/src/features/auth/data/models/verify_request_model/verify_request_model.dart';
import 'package:client_auth/src/features/auth/domain/entities/auth_login_request.dart';
import 'package:client_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('serializes login request with nested snake_case device fields', () {
    const entity = AuthLoginRequest(
      email: 'client@example.com',
      device: AuthDeviceInfo(
        deviceId: 'device-id',
        os: 'ios',
        osVersion: '18',
        model: 'iPhone',
        appVersion: '1.0.0',
      ),
    );

    expect(AuthLoginRequestModel.fromEntity(entity).toJson(), {
      'email': 'client@example.com',
      'device': {
        'device_id': 'device-id',
        'os': 'ios',
        'os_version': '18',
        'model': 'iPhone',
        'app_version': '1.0.0',
      },
    });
  });

  test('serializes verify request with snake_case fields', () {
    const entity = VerifyRequest(
      loginRequestId: 'request-id',
      email: 'client@example.com',
      code: '123456',
    );

    expect(VerifyRequestModel.fromEntity(entity).toJson(), {
      'login_request_id': 'request-id',
      'email': 'client@example.com',
      'code': '123456',
    });
  });
}
