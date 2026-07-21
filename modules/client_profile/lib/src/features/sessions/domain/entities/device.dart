import 'package:equatable/equatable.dart';

class Device extends Equatable {

  const Device({
    required this.id,
    required this.clientDeviceId,
    required this.os,
    required this.osVersion,
    required this.model,
    required this.appVersion,
    required this.hasNotificationToken, this.pushProvider,
  });
  final String id;
  final String clientDeviceId;
  final String os;
  final String osVersion;
  final String model;
  final String appVersion;
  final String? pushProvider;
  final bool hasNotificationToken;

  @override
  List<Object?> get props => [
    id,
    clientDeviceId,
    os,
    osVersion,
    model,
    appVersion,
    pushProvider,
    hasNotificationToken,
  ];
}
