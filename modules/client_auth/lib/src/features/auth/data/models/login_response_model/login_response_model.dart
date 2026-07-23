import 'package:client_auth/src/features/auth/domain/entities/login_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends LoginResponse {
  const LoginResponseModel({
    required super.message,
    required super.loginRequestId,
    required super.otpExpiresIn,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  factory LoginResponseModel.fromEntity(LoginResponse entity) =>
      LoginResponseModel(
        message: entity.message,
        loginRequestId: entity.loginRequestId,
        otpExpiresIn: entity.otpExpiresIn,
      );

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
