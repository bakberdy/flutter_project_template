import 'package:admin_auth/src/features/auth/data/models/auth_device_info_model/auth_device_info_model.dart';
import 'package:admin_auth/src/features/auth/domain/entities/auth_login_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_login_request_model.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
class AuthLoginRequestModel {
  const AuthLoginRequestModel({required this.email, required this.device});

  factory AuthLoginRequestModel.fromEntity(AuthLoginRequest entity) =>
      AuthLoginRequestModel(
        email: entity.email,
        device: AuthDeviceInfoModel.fromEntity(entity.device),
      );

  final String email;
  final AuthDeviceInfoModel device;

  Map<String, dynamic> toJson() => _$AuthLoginRequestModelToJson(this);
}
