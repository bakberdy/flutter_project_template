import 'package:equatable/equatable.dart';

class AuthDeviceInfo extends Equatable {

  const AuthDeviceInfo({
    required this.deviceId,
    required this.os,
    required this.osVersion,
    required this.model,
    required this.appVersion,
    this.pushProvider,
    this.pushToken,
  });
  final String deviceId;
  final String os;
  final String osVersion;
  final String model;
  final String appVersion;
  final String? pushProvider;
  final String? pushToken;

  @override
  List<Object?> get props => [
    deviceId,
    os,
    osVersion,
    model,
    appVersion,
    pushProvider,
    pushToken,
  ];
}

class AuthLoginRequest extends Equatable {

  const AuthLoginRequest({required this.email, required this.device});
  final String email;
  final AuthDeviceInfo device;

  @override
  List<Object?> get props => [email, device];
}
