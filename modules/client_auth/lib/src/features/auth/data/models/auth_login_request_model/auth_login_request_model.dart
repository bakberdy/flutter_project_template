import 'package:client_auth/src/features/auth/data/models/auth_device_info_model/auth_device_info_model.dart';
import 'package:client_auth/src/features/auth/domain/entities/auth_login_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_login_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthLoginRequestModel extends AuthLoginRequest {
  const AuthLoginRequestModel({
    required super.email,
    required AuthDeviceInfoModel device,
  }) : super(device: device);

  factory AuthLoginRequestModel.fromEntity(AuthLoginRequest entity) =>
      AuthLoginRequestModel(
        email: entity.email,
        device: AuthDeviceInfoModel.fromEntity(entity.device),
      );

  factory AuthLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginRequestModelFromJson(json);

  @override
  AuthDeviceInfoModel get device => super.device as AuthDeviceInfoModel;

  Map<String, dynamic> toJson() => _$AuthLoginRequestModelToJson(this);
}
