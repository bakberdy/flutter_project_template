import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/device/user_device.dart';

part 'user_device_model.g.dart';

@JsonSerializable(includeIfNull: false)
class UserDeviceModel extends UserDevice {
  const UserDeviceModel({
    required super.os,
    required super.osVersion,
    required super.model,
    required super.appVersion,
    super.id,
    super.deviceId,
    super.clientDeviceId,
    super.pushProvider,
    super.pushToken,
    super.hasNotificationToken,
  });

  factory UserDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$UserDeviceModelFromJson(json);

  factory UserDeviceModel.fromEntity(UserDevice entity) => UserDeviceModel(
    id: entity.id,
    deviceId: entity.deviceId,
    clientDeviceId: entity.clientDeviceId,
    os: entity.os,
    osVersion: entity.osVersion,
    model: entity.model,
    appVersion: entity.appVersion,
    pushProvider: entity.pushProvider,
    pushToken: entity.pushToken,
    hasNotificationToken: entity.hasNotificationToken,
  );

  Map<String, dynamic> toJson() => _$UserDeviceModelToJson(this);
}
