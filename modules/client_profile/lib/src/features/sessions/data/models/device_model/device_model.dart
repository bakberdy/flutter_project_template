import 'package:client_profile/src/features/sessions/domain/entities/device.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_model.g.dart';

@JsonSerializable(createToJson: false)
class DeviceModel extends Device {
  const DeviceModel({
    required super.id,
    required super.clientDeviceId,
    required super.os,
    required super.osVersion,
    required super.model,
    required super.appVersion,
    super.pushProvider,
    super.hasNotificationToken = false,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  factory DeviceModel.fromEntity(Device device) => DeviceModel(
    id: device.id,
    clientDeviceId: device.clientDeviceId,
    os: device.os,
    osVersion: device.osVersion,
    model: device.model,
    appVersion: device.appVersion,
    pushProvider: device.pushProvider,
    hasNotificationToken: device.hasNotificationToken,
  );
}
