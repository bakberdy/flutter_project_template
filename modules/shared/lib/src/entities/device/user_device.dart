import 'package:equatable/equatable.dart';

class UserDevice extends Equatable {
  const UserDevice({
    required this.os,
    required this.osVersion,
    required this.model,
    required this.appVersion,
    this.id,
    this.deviceId,
    this.clientDeviceId,
    this.pushProvider,
    this.pushToken,
    this.hasNotificationToken,
  });

  final String? id;
  final String? deviceId;
  final String? clientDeviceId;
  final String os;
  final String osVersion;
  final String model;
  final String appVersion;
  final String? pushProvider;
  final String? pushToken;
  final bool? hasNotificationToken;

  @override
  List<Object?> get props => [
    id,
    deviceId,
    clientDeviceId,
    os,
    osVersion,
    model,
    appVersion,
    pushProvider,
    pushToken,
    hasNotificationToken,
  ];
}
