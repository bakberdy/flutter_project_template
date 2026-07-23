import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/auth/auth_login_request.dart';
import 'package:shared/src/models/device/user_device_model/user_device_model.dart';

part 'auth_login_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthLoginRequestModel extends AuthLoginRequest {
  const AuthLoginRequestModel({
    required super.email,
    required UserDeviceModel device,
  }) : super(device: device);

  factory AuthLoginRequestModel.fromEntity(AuthLoginRequest entity) =>
      AuthLoginRequestModel(
        email: entity.email,
        device: UserDeviceModel.fromEntity(entity.device),
      );

  factory AuthLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginRequestModelFromJson(json);

  @override
  UserDeviceModel get device => super.device as UserDeviceModel;

  Map<String, dynamic> toJson() => _$AuthLoginRequestModelToJson(this);
}
