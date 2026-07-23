import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/auth/auth_login_response.dart';

part 'auth_login_response_model.g.dart';

@JsonSerializable()
class AuthLoginResponseModel extends AuthLoginResponse {
  const AuthLoginResponseModel({
    required super.message,
    required super.loginRequestId,
    required super.otpExpiresIn,
  });

  factory AuthLoginResponseModel.fromEntity(AuthLoginResponse entity) =>
      AuthLoginResponseModel(
        message: entity.message,
        loginRequestId: entity.loginRequestId,
        otpExpiresIn: entity.otpExpiresIn,
      );

  factory AuthLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLoginResponseModelToJson(this);
}
