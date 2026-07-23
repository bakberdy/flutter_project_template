import 'package:admin_auth/src/features/auth/domain/entities/auth_login_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_device_info_model.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class AuthDeviceInfoModel extends AuthDeviceInfo {
  const AuthDeviceInfoModel({
    required super.deviceId,
    required super.os,
    required super.osVersion,
    required super.model,
    required super.appVersion,
    super.pushProvider,
    super.pushToken,
  });

  factory AuthDeviceInfoModel.fromEntity(AuthDeviceInfo entity) =>
      AuthDeviceInfoModel(
        deviceId: entity.deviceId,
        os: entity.os,
        osVersion: entity.osVersion,
        model: entity.model,
        appVersion: entity.appVersion,
        pushProvider: entity.pushProvider,
        pushToken: entity.pushToken,
      );

  factory AuthDeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AuthDeviceInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDeviceInfoModelToJson(this);
}
