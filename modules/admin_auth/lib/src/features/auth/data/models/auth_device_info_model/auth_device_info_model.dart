import 'package:admin_auth/src/features/auth/domain/entities/auth_login_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_device_info_model.g.dart';

@JsonSerializable(
  createFactory: false,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class AuthDeviceInfoModel {
  const AuthDeviceInfoModel({
    required this.deviceId,
    required this.os,
    required this.osVersion,
    required this.model,
    required this.appVersion,
    this.pushProvider,
    this.pushToken,
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

  final String deviceId;
  final String os;
  final String osVersion;
  final String model;
  final String appVersion;
  final String? pushProvider;
  final String? pushToken;

  Map<String, dynamic> toJson() => _$AuthDeviceInfoModelToJson(this);
}
