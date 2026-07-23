import 'package:client_auth/src/features/auth/domain/entities/auth_login_request.dart';

final class AuthLoginRequestJson {
  AuthLoginRequestJson._();

  static Map<String, dynamic> toMap(AuthLoginRequest request) => {
    'email': request.email,
    'device': {
      'device_id': request.device.deviceId,
      'os': request.device.os,
      'os_version': request.device.osVersion,
      'model': request.device.model,
      'app_version': request.device.appVersion,
      if (request.device.pushProvider != null)
        'push_provider': request.device.pushProvider,
      if (request.device.pushToken != null)
        'push_token': request.device.pushToken,
    },
  };
}
