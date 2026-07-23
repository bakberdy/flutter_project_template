import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/sessions/user_session_device.dart';

part 'user_session_device_model.g.dart';

@JsonSerializable()
class UserSessionDeviceModel extends UserSessionDevice {
  const UserSessionDeviceModel({
    required super.id,
    required super.clientDeviceId,
    required super.os,
    required super.osVersion,
    required super.model,
    required super.appVersion,
    super.pushProvider,
    super.hasNotificationToken = false,
  });

  factory UserSessionDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$UserSessionDeviceModelFromJson(json);

  factory UserSessionDeviceModel.fromEntity(UserSessionDevice entity) =>
      UserSessionDeviceModel(
        id: entity.id,
        clientDeviceId: entity.clientDeviceId,
        os: entity.os,
        osVersion: entity.osVersion,
        model: entity.model,
        appVersion: entity.appVersion,
        pushProvider: entity.pushProvider,
        hasNotificationToken: entity.hasNotificationToken,
      );

  Map<String, dynamic> toJson() => _$UserSessionDeviceModelToJson(this);
}
